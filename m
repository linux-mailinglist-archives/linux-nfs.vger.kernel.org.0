Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F049BFB9
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 00:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiAYXsl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 18:48:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49118 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiAYXsl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 18:48:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 238F1212BC;
        Tue, 25 Jan 2022 23:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643154520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szKKP58FaOHSHo7lNIll7CEj9TD2wqk0M0TB49wzSEg=;
        b=Ij1U2hK/x6RPlzKyMLhJkrb2OIATBUXg5eAAPBwAv+v5AyXv7TQjKI2Uc7VCtkPEB0MyBd
        aArTXFWQAYSVKOnHlhdctA7NyyWhNaeTxfbiggqLByFaBHbBewr0IYrNEUFZ2epVsBEP4B
        9lmEWn/cXHGR1gqeDeMyMke4ZPYrVbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643154520;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szKKP58FaOHSHo7lNIll7CEj9TD2wqk0M0TB49wzSEg=;
        b=JEEDn8pjIFSemAAxJgelXy+Kd7ywaka+SwRyLJsq9ZEf6du/rU8g2iDYKqCnwHlqXEa1MR
        m5bzkry5vZ4spvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 793CA13EF2;
        Tue, 25 Jan 2022 23:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tNiaDVaM8GEBbQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 25 Jan 2022 23:48:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Bruce Fields" <bfields@redhat.com>
Cc:     "Petr Vorel" <pvorel@suse.cz>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Yong Sun" <yosun@suse.com>,
        "Frank S. Filz" <ffilzlnx@mindspring.com>
Subject: Re: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
In-reply-to: <CAPL3RVE8+zYOLotpUQ6QWFy5rYS8o1NV6XbKE4-D6XpVSoYw3w@mail.gmail.com>
References: <YLY9pKu38lEWaXxE@pevik>, <YLZS1iMJR59n4hue@pick.fieldses.org>,
 <164248153844.24166.16775550865302060652@noble.neil.brown.name>,
 <CAPL3RVE8+zYOLotpUQ6QWFy5rYS8o1NV6XbKE4-D6XpVSoYw3w@mail.gmail.com>
Date:   Wed, 26 Jan 2022 10:48:35 +1100
Message-id: <164315451558.5493.17782132429187259258@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Jan 2022, Bruce Fields wrote:
> Frank added this test in 4299316fb357, and I don't really understand
> his description, but it *sounds* like he really wanted it to do the
> new-lockowner case.  Frank?

The way I read that commit message, there needs to be a second lock
owner (as you suggest), but there clearly isn't one.
Maybe there needs to be a second open_sequence() created ...  I'm not
sure.

NeilBrown
