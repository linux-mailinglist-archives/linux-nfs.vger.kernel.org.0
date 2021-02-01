Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A530A214
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Feb 2021 07:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhBAGjA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 1 Feb 2021 01:39:00 -0500
Received: from 202-142-134-175.ca8e86.mel.static.aussiebb.net ([202.142.134.175]:51444
        "EHLO mail.extremenerds.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232153AbhBAGQX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Feb 2021 01:16:23 -0500
Received: from [192.168.1.81] (unknown [192.168.1.81])
        by mail.extremenerds.net (Postfix) with ESMTPS id 47B2647696;
        Mon,  1 Feb 2021 17:14:59 +1100 (AEDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH v1] SUNRPC: Fix NFS READs that start at non-page-aligned
 offsets
From:   "A. Duvnjak" <avian@extremenerds.net>
In-Reply-To: <161214078155.1093.2334504504623797564.stgit@klimt.1015granger.net>
Date:   Mon, 1 Feb 2021 17:14:53 +1100
Cc:     linux-nfs@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A1D67DE8-6DA9-432C-B91D-A2AD6B148656@extremenerds.net>
References: <161214078155.1093.2334504504623797564.stgit@klimt.1015granger.net>
To:     Chuck Lever <chuck.lever@oracle.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I tried this patch on 5.10.12 (which would normally produce streaming errors).  So far it works well.   Have tried it in the three situations that would previously cause issues -  Kodi on Windows,  Kodi on Mac, and the Windows 10 NFS client with VLC.  All check out fine.


> On 1 Feb 2021, at 11:53 am, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> Anj Duvnjak reports that the Kodi.tv NFS client is not able to read
> video files from a v5.10.11 Linux NFS server.
> 
> The new sendpage-based TCP sendto logic was not attentive to non-
> zero page_base values. nfsd_splice_read() sets that field when a
> READ payload starts in the middle of a page.
> 
> The Linux NFS client rarely emits an NFS READ that is not page-
> aligned. All of my testing so far has been with Linux clients, so I
> missed this one.
> 
> Reported-by: A. Duvnjak <avian@extremenerds.net>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=211471
> Fixes: 4a85a6a3320b ("SUNRPC: Handle TCP socket sends with kernel_sendpage() again")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/svcsock.c |    7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index c9766d07eb81..5a809c64dc7b 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1113,14 +1113,15 @@ static int svc_tcp_sendmsg(struct socket *sock, struct msghdr *msg,
> 		unsigned int offset, len, remaining;
> 		struct bio_vec *bvec;
> 
> -		bvec = xdr->bvec;
> -		offset = xdr->page_base;
> +		bvec = xdr->bvec + (xdr->page_base >> PAGE_SHIFT);
> +		offset = offset_in_page(xdr->page_base);
> 		remaining = xdr->page_len;
> 		flags = MSG_MORE | MSG_SENDPAGE_NOTLAST;
> 		while (remaining > 0) {
> 			if (remaining <= PAGE_SIZE && tail->iov_len == 0)
> 				flags = 0;
> -			len = min(remaining, bvec->bv_len);
> +
> +			len = min(remaining, bvec->bv_len - offset);
> 			ret = kernel_sendpage(sock, bvec->bv_page,
> 					      bvec->bv_offset + offset,
> 					      len, flags);
> 
> 

