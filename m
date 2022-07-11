Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AC85709AF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiGKSF2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGKSF1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:05:27 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21AE220F8
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 11:05:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3AB2C64A6; Mon, 11 Jul 2022 14:05:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3AB2C64A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1657562722;
        bh=npTDQANjZu2Li+K4WkeB01OhkHJunDwIw5tvbghsje4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sON7tt+qkX9BxptIrGUMrFhwLpH1yI9GBuSNOmfatlduU9eDe41i/sL/J8FRfe6np
         leKjSOHfpeVYIZYEfHoihqfCXyoS9xS5mHEBuSkLzkTEMJ88lX3GsGTYzs5Aa1jTfi
         foEqItcxUBzJnTYajB3wM5gmuaNv9gp7OxN3Kgsk=
Date:   Mon, 11 Jul 2022 14:05:22 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfs4lib.py: enhance open_file to work with courteous
 server
Message-ID: <20220711180522.GA14184@fieldses.org>
References: <1655314495-17735-1-git-send-email-dai.ngo@oracle.com>
 <20220615193453.GB16220@fieldses.org>
 <d0db9a5c-01f3-2380-20ab-36c1e78e395d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0db9a5c-01f3-2380-20ab-36c1e78e395d@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applying, thanks, sorry for the delay.--b.

On Wed, Jun 15, 2022 at 12:48:17PM -0700, dai.ngo@oracle.com wrote:
> 
> On 6/15/22 12:34 PM, J. Bruce Fields wrote:
> >THere are tests that want to explicitly test for DELAY returns.  (Grep
> >for ERR_DELAY.  Look at the delegation tests especially.)  Does this
> >work for them?
> 
> Those tests expect NFS4_OK but also handle NFS4ERR_DELAY themselves
> if the OPEN causes recall. With this patch, the NFS4ERR_DELAY is handled
> internally by open_file so the ERR_DELAY never get to those tests.
> All tests passed with this patch.
> 
> -Dai
> 
> >  I assumed we'd want an optional parameter that allowed
> >to caller to circument the DELAY handling.
> >
> >--b.
> >
> >On Wed, Jun 15, 2022 at 10:34:54AM -0700, Dai Ngo wrote:
> >>Enhance open_file to handle NFS4ERR_DELAY returned by the server
> >>in case of share/access/delegation conflict.
> >>
> >>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>---
> >>  nfs4.0/nfs4lib.py | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> >>index 934def3b7333..e0299e8d6676 100644
> >>--- a/nfs4.0/nfs4lib.py
> >>+++ b/nfs4.0/nfs4lib.py
> >>@@ -677,7 +677,12 @@ class NFS4Client(rpc.RPCClient):
> >>                            claim_type=claim_type, deleg_type=deleg_type,
> >>                            deleg_cur_info=deleg_cur_info)]
> >>          ops += [op4.getfh()]
> >>-        res = self.compound(ops)
> >>+        while 1:
> >>+            res = self.compound(ops)
> >>+            if res.status == NFS4ERR_DELAY:
> >>+                time.sleep(2)
> >>+            else:
> >>+                break
> >>          self.advance_seqid(owner, res)
> >>          if set_recall and (res.status != NFS4_OK or \
> >>             res.resarray[-2].switch.switch.delegation == OPEN_DELEGATE_NONE):
> >>-- 
> >>2.27.0
