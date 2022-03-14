Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432264D8F5D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 23:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiCNWNg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 18:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiCNWNf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 18:13:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE6B3C72D
        for <linux-nfs@vger.kernel.org>; Mon, 14 Mar 2022 15:12:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8D8B4210F3;
        Mon, 14 Mar 2022 22:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647295943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8XtGQ0UPE3oySZHTomeLAjnji77vFZAwVgP7N4olIU=;
        b=j0QwV5LX2cfVDc1/5/Az/LCJd2jggXLlHW+yWStACNPFplFbUTBVt+2E98QZP7lfe0CqLO
        8eJEIGsfIYFZaAVERZkvLQ7mpuM/Eb6zd0ugM2lZgJLK1ScrgUmb+M1bdTBC8GEDDQ4RSG
        vh677CNhmkVkb1l9jjMRir0QyCRIkN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647295943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8XtGQ0UPE3oySZHTomeLAjnji77vFZAwVgP7N4olIU=;
        b=ATCThAVe46Bas7iUHUPSVseJ4QpBvX0t1iIgwPKEPxCtRfU0AuNsbS+sQ3jBLBlttbpZkS
        JS2O/o4kTP+QE5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC1AB13ADA;
        Mon, 14 Mar 2022 22:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l0hpJcW9L2KrJwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 14 Mar 2022 22:12:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Steve Dickson" <SteveD@RedHat.com>,
        "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfs.man: document requirements for NFSv4 identity
In-reply-to: <8EF0A369-CDE5-4FA1-9085-A6BB96C711C8@redhat.com>
References: <164721984672.11933.15475930163427511814@noble.neil.brown.name>,
 <8EF0A369-CDE5-4FA1-9085-A6BB96C711C8@redhat.com>
Date:   Tue, 15 Mar 2022 09:12:17 +1100
Message-id: <164729593739.11933.17105376922838726146@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Thanks for the typo fixes Ben - I've applied them o my local copy.

NeilBrown
