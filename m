Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE34D3E66
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Mar 2022 01:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiCJAtT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 19:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiCJAtT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 19:49:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6361D90FFC
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 16:48:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59A471F39E;
        Thu, 10 Mar 2022 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646873297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKdRmMnS0gz0HT5/Qpd12IWrYt9WF4Gk9UPNcDSkgG4=;
        b=M+DutNPwEcj36jPDlP5Oq92h0votj0WAhKvI3pMM3f9XsTe7G6nxn7gg8acdULWej4hEe0
        k+rUlpw8RsSjpsGqDI9SDwuibBD0HhF6Q9F31pooSMfJ9W/IMcN4Soqu3Et7oCrKsmm7fR
        QYO3nMVpkk8NvXLqyBt5RKgINT81pHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646873297;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKdRmMnS0gz0HT5/Qpd12IWrYt9WF4Gk9UPNcDSkgG4=;
        b=lyvfk3Ph8xmELkZdfbIP07GqeUGD8utDvCYIUZXSAZKKX7CRXutnZ4HY2SPerdUa0QAgY9
        Akywy5gEb3ByUCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EF6E13D80;
        Thu, 10 Mar 2022 00:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tjLbNc9KKWJoLAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 10 Mar 2022 00:48:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/11] Various NFS/sunrpc improvements for swap-over-NFS
In-reply-to: <164660993703.31054.17075972410545449555.stgit@noble.brown>
References: <164660993703.31054.17075972410545449555.stgit@noble.brown>
Date:   Thu, 10 Mar 2022 11:48:09 +1100
Message-id: <164687328986.31932.14664341490828467390@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 07 Mar 2022, NeilBrown wrote:
> swap-over-NFS currently doesn't work.  Even after these patches it still
> won't work.  Some core MM changes are needed.
> However these patches make a number of improvements to NFS and SUNRPC so
> that swap-over-NFS can work once those mm changes land.
> 
> There is one change since the last posting of these patches.
> The last patch was added to fix a potential hang when enabling swap.
> 
> Trond/Anna - is their any chance these can go in on the next merge
> window?
> 
> Thanks,
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (11):
>       NFS: remove IS_SWAPFILE hack
>       SUNRPC/call_alloc: async tasks mustn't block waiting for memory
>       SUNRPC/auth: async tasks mustn't block waiting for memory
>       SUNRPC/xprt: async tasks mustn't block waiting for memory

I note that the above two have minor conflcts when applied to linux-next
due to some GFP_NOFS having been changed to GFP_KERNEL.  Would you like
me to resend thee two?  Or resend the series?  Or are you happy to just
if it up?

Thanks,
NeilBrown
