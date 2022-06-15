Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DD054D1AE
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 21:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiFOTe5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347369AbiFOTez (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 15:34:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F129815
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 12:34:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1B71044D2; Wed, 15 Jun 2022 15:34:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1B71044D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1655321693;
        bh=8dACd0xyp04tqZjKzGDBF9sH1Q1VrJaGPqcDi8OkCKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsOfD5H6qXAivQm00W7XGnawxWqo3kPMfH1Egf+b0wZiAwoNGVRSVNKlhC8wXS10S
         HV6LxOwafU4xCYwcJEEbg54OzDMfcn1A4sN2Apar9KGk89DykM9Fz6w3IQZrM2YAlq
         HtDW0ojqqmh1rZFiZL4oiBU70SFYiqAInmb8YmeQ=
Date:   Wed, 15 Jun 2022 15:34:53 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfs4lib.py: enhance open_file to work with courteous
 server
Message-ID: <20220615193453.GB16220@fieldses.org>
References: <1655314495-17735-1-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655314495-17735-1-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

THere are tests that want to explicitly test for DELAY returns.  (Grep
for ERR_DELAY.  Look at the delegation tests especially.)  Does this
work for them?  I assumed we'd want an optional parameter that allowed
to caller to circument the DELAY handling.

--b.

On Wed, Jun 15, 2022 at 10:34:54AM -0700, Dai Ngo wrote:
> Enhance open_file to handle NFS4ERR_DELAY returned by the server
> in case of share/access/delegation conflict.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  nfs4.0/nfs4lib.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> index 934def3b7333..e0299e8d6676 100644
> --- a/nfs4.0/nfs4lib.py
> +++ b/nfs4.0/nfs4lib.py
> @@ -677,7 +677,12 @@ class NFS4Client(rpc.RPCClient):
>                            claim_type=claim_type, deleg_type=deleg_type,
>                            deleg_cur_info=deleg_cur_info)]
>          ops += [op4.getfh()]
> -        res = self.compound(ops)
> +        while 1:
> +            res = self.compound(ops)
> +            if res.status == NFS4ERR_DELAY:
> +                time.sleep(2)
> +            else:
> +                break
>          self.advance_seqid(owner, res)
>          if set_recall and (res.status != NFS4_OK or \
>             res.resarray[-2].switch.switch.delegation == OPEN_DELEGATE_NONE):
> -- 
> 2.27.0
