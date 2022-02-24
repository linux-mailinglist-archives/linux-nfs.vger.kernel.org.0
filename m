Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA64C3804
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 22:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiBXVuR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 16:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiBXVuR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 16:50:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE3122A2A3
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 13:49:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30F62212C0;
        Thu, 24 Feb 2022 21:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645739383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvuJ3OoAyDi8/vXmpOMGFd3EvwNT+UpaWjL8u7LVl5A=;
        b=wCMnqg1TcbXPYfrzJXpXhjb1Nomo9yhYDPa3li7tFcKItK4aPSVYFGja9U4X/liFfCq7Ax
        XsCwLpKyDnehCBQiyxorX8RSDXab4Y02yg6hHn7ikw/R94AU87jhuwVApMZJ/VpWxxkd1u
        TxuXcOFaeMWm6KIKyiBuh4HB2JDZyMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645739383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvuJ3OoAyDi8/vXmpOMGFd3EvwNT+UpaWjL8u7LVl5A=;
        b=uSpCfAUqpjuWOeuJdWXz7qvV/Kd9uuL2G4B94G9mM3mmA9QBO06SK5C5XPWA8BuAzE4kvR
        eIcmV7AXRTzut4AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D045713B2D;
        Thu, 24 Feb 2022 21:49:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hkjqInX9F2IUbgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 24 Feb 2022 21:49:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
In-reply-to: <20220224161705.1041788-1-amir73il@gmail.com>
References: <20220224161705.1041788-1-amir73il@gmail.com>
Date:   Fri, 25 Feb 2022 08:49:36 +1100
Message-id: <164573937670.25116.10310536737134724947@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 25 Feb 2022, Amir Goldstein wrote:
> The nfsd file cache table can be pretty large and its allocation
> may require as many as 80 contigious pages.
>=20
> Employ the same fix that was employed for similar issue that was
> reported for the reply cache hash table allocation several years ago
> by commit 8f97514b423a ("nfsd: more robust allocation failure handling
> in nfsd_reply_cache_init").
>=20
> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
> Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327c0381=
c1778.camel@kernel.org/
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>=20
> Since v1:
> - Use kvcalloc()
> - Use kvfree()

I think this is a good improvement, but it would be really nice to
replace this bespoke hash table with an rhashtable.  They we wouldn't
need to worry about these trivial details.

NeilBrown
