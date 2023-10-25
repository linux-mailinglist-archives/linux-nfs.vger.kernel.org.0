Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7287D7620
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjJYU52 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 16:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYU51 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 16:57:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2DCE
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 13:57:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5CEC5219D3;
        Wed, 25 Oct 2023 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698267442;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Aijyy5slDkoNPKC2ZAbwn0uJdnU+/oZpF39t1RYr1M=;
        b=XQCriasLZ0TclA6Tay0FCc+3luH8Np0rJPOdk+22PKymYN1VeU63eZd6iMyBRLa9vI0JBH
        MqcKyIKt05gsz9jgNkk5P0qBs5QcFGTY16jnIrZK0FQoFCg9EWh0er8V811FdynUWKQqgb
        AzZdSYk1vbWzN/14jJyu3KyIthvPpoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698267442;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Aijyy5slDkoNPKC2ZAbwn0uJdnU+/oZpF39t1RYr1M=;
        b=eZv0jBj952l7de4Va/llKvcggcJeJFhToNcKjZ10mkM667fLmiEGrlOp6ya6YMnQOjQ4yu
        +v2mE54hAJ0IoBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24AD513524;
        Wed, 25 Oct 2023 20:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5q6nBzKBOWVNKgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 20:57:22 +0000
Date:   Wed, 25 Oct 2023 22:57:20 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Richard Weinberger <richard@nod.at>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH 0/3] Add getrandom() fallback, cleanup headers
Message-ID: <20231025205720.GB460410@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20231025194701.456031-1-pvorel@suse.cz>
 <857096093.3016.1698264780882.JavaMail.zimbra@nod.at>
 <20231025205455.GA460410@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025205455.GA460410@pevik>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.28
X-Spamd-Result: default: False [-6.28 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[pvorel@suse.cz];
         REPLYTO_EQ_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.98)[99.92%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

> 1) sleep on EAGAIN and try again (needed to be handled due GRND_NONBLOCK).

(man getrandom(2))

Kind regards,
Petr
