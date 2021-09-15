Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073AB40BFAD
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Sep 2021 08:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhIOGfm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 02:35:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45762 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhIOGfl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 02:35:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1429221BF;
        Wed, 15 Sep 2021 06:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631687661;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3ncWHVObQ7lLekPSOO9isLxil9m9NNKRNRPh5T3J9I=;
        b=t+uaCVsHZyGvisjED9AujS1RKmwRIKNsPo/wZB0KYqGMtbNwEnTfXG3jzUeWH9DtcN/eOG
        P8g4JW7TQmcCgxKJR5q4ce9y6AwOv5N4j054E6h5bX5xgLl8j7YBuUukjPGok1qYGgIFk4
        F62eTQ+SSC+5yX8xl3xbpb8sGUpiJfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631687661;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3ncWHVObQ7lLekPSOO9isLxil9m9NNKRNRPh5T3J9I=;
        b=NTl5kYK2fYwK43SJ1lwkTNvob+EkY0EJfYujLfHQS8YjpPyqnjeK11VztzImM1bVhMVD1Y
        Wfq7YgVq9HG43nBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 915D813C1A;
        Wed, 15 Sep 2021 06:34:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e3Y5Iu2TQWEffAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 15 Sep 2021 06:34:21 +0000
Date:   Wed, 15 Sep 2021 08:34:20 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] gssd: fix crash in debug message.
Message-ID: <YUGT7KtANB4K7WNb@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210610150825.396565-1-steved@redhat.com>
 <627209c3-21dd-312e-c2dc-cc810108f7d1@redhat.com>
 <163116618506.12570.5744024691858636230@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163116618506.12570.5744024691858636230@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve, Neil,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
