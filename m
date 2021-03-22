Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E6C344D90
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 18:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhCVRjb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 13:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCVRj3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 13:39:29 -0400
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Mar 2021 10:39:29 PDT
Received: from cosmos.ssec.wisc.edu (cosmos-v6.ssec.wisc.edu [IPv6:2607:f388:1090:0:fab1:56ff:fedf:5d9c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 349D3C061574;
        Mon, 22 Mar 2021 10:39:29 -0700 (PDT)
Received: by cosmos.ssec.wisc.edu (Postfix, from userid 388)
        id D6C9B1647C5; Mon, 22 Mar 2021 12:31:42 -0500 (CDT)
Date:   Mon, 22 Mar 2021 12:31:42 -0500
From:   Daniel Forrest <dforrest@wisc.edu>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 4/6] svcrdma: Add a batch Receive posting mechanism
Message-ID: <20210322173142.GA10610@cosmos.ssec.wisc.edu>
Reply-To: Daniel Forrest <dforrest@wisc.edu>
Mail-Followup-To: Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
 <161616429593.173092.14052996014785354959.stgit@klimt.1015granger.net>
 <20210322171614.GB24580@fieldses.org>
 <756ACA71-4AFC-441C-BD5C-4D95EF713C9C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756ACA71-4AFC-441C-BD5C-4D95EF713C9C@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 22, 2021 at 05:17:35PM +0000, Chuck Lever III wrote:
> 
> 
> > On Mar 22, 2021, at 1:16 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Fri, Mar 19, 2021 at 10:31:35AM -0400, Chuck Lever wrote:
> >> Introduce a server-side mechanism similar to commit e340c2d6ef2a
> >> ("xprtrdma: Reduce the doorbell rate (Receive)") to post Receive
> >> WRs in batch. It's first consumer is svc_rdma_post_recvs().
> > 
> > s/It's/Its'/.
> 
> D'oh!
> 

Except there should be no apostrophe at all, just plain "Its".

> 
> > Patches look OK to me.--b.
> 
> Thanks for the review!
> 
> 
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   56 +++++++++++++++++++++++--------
> >> 1 file changed, 42 insertions(+), 14 deletions(-)
> >> 
> >> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> >> index 04148a656b2a..0c6aa8693f20 100644
> >> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> >> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> >> @@ -264,6 +264,47 @@ void svc_rdma_release_rqst(struct svc_rqst *rqstp)
> >> 		svc_rdma_recv_ctxt_put(rdma, ctxt);
> >> }
> >> 
> >> +static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
> >> +				   unsigned int wanted, bool temp)
> >> +{
> >> +	const struct ib_recv_wr *bad_wr = NULL;
> >> +	struct svc_rdma_recv_ctxt *ctxt;
> >> +	struct ib_recv_wr *recv_chain;
> >> +	int ret;
> >> +
> >> +	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
> >> +		return false;
> >> +
> >> +	recv_chain = NULL;
> >> +	while (wanted--) {
> >> +		ctxt = svc_rdma_recv_ctxt_get(rdma);
> >> +		if (!ctxt)
> >> +			break;
> >> +
> >> +		trace_svcrdma_post_recv(ctxt);
> >> +		ctxt->rc_temp = temp;
> >> +		ctxt->rc_recv_wr.next = recv_chain;
> >> +		recv_chain = &ctxt->rc_recv_wr;
> >> +	}
> >> +	if (!recv_chain)
> >> +		return false;
> >> +
> >> +	ret = ib_post_recv(rdma->sc_qp, recv_chain, &bad_wr);
> >> +	if (ret)
> >> +		goto err_free;
> >> +	return true;
> >> +
> >> +err_free:
> >> +	trace_svcrdma_rq_post_err(rdma, ret);
> >> +	while (bad_wr) {
> >> +		ctxt = container_of(bad_wr, struct svc_rdma_recv_ctxt,
> >> +				    rc_recv_wr);
> >> +		bad_wr = bad_wr->next;
> >> +		svc_rdma_recv_ctxt_put(rdma, ctxt);
> >> +	}
> >> +	return false;
> >> +}
> >> +
> >> static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
> >> 				struct svc_rdma_recv_ctxt *ctxt)
> >> {
> >> @@ -301,20 +342,7 @@ static int svc_rdma_post_recv(struct svcxprt_rdma *rdma)
> >>  */
> >> bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
> >> {
> >> -	struct svc_rdma_recv_ctxt *ctxt;
> >> -	unsigned int i;
> >> -	int ret;
> >> -
> >> -	for (i = 0; i < rdma->sc_max_requests; i++) {
> >> -		ctxt = svc_rdma_recv_ctxt_get(rdma);
> >> -		if (!ctxt)
> >> -			return false;
> >> -		ctxt->rc_temp = true;
> >> -		ret = __svc_rdma_post_recv(rdma, ctxt);
> >> -		if (ret)
> >> -			return false;
> >> -	}
> >> -	return true;
> >> +	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests, true);
> >> }
> >> 
> >> /**
> >> 
> 
> --
> Chuck Lever

-- 
Dan
