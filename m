Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4961E4BACAC
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 23:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbiBQWhA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 17:37:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiBQWg6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 17:36:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA29116921D
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 14:36:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 098A7210DC;
        Thu, 17 Feb 2022 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645137402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6xH+GLNf2HcdpkX5IOFaVo/1N9mwwBlgA9AlaXPurg=;
        b=xO5v918/kvUGhN31oDstJ/BnDiF2GBHne9gxEutY/f+fIwb+xn4KtcpcUoO3iF0z36MRdl
        RlNHc8sNulYFRoQklL38tD3F8WmIOpYm2nDP3eeRg3/AB0qzNnEVwAYIGD2RTAf5UXDYYk
        S5vN2+t2GXffc+ZItlVKOnJBPstNd8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645137402;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6xH+GLNf2HcdpkX5IOFaVo/1N9mwwBlgA9AlaXPurg=;
        b=LYS4bf0BjTdPjWlbVGIaFs0K0IIt9kYM+XASrDJg2ezxKcf2xY5+BUyNSXyLE+DZMOfKXe
        Byb5guMPrWMDJUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31B7B13BE1;
        Thu, 17 Feb 2022 22:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +ROvN/jNDmJkEgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 17 Feb 2022 22:36:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Clean up struct svc_serv_ops
In-reply-to: <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
References: <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
Date:   Fri, 18 Feb 2022 09:36:37 +1100
Message-id: <164513739771.10228.8490335253199789553@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 18 Feb 2022, Chuck Lever wrote:
> Here is the completed series of patches to remove struct
> svc_serv_ops, as suggested by Neil Brown. The original material was
> introduced several years ago when we planned to convert the RPC
> server to use work queues. That work was never completed.
> 
> Removal now is to eliminate some unnecessary virtual functions
> and to pave the way for the possibility of dynamic nfsd thread
> management.
> 
> The full set of patches has been provisionally applied to my
> for-next branch to enable broad testing. Comments welcome.

All looks good - lots of nice cleanups there.

Thanks,
NeilBrown
