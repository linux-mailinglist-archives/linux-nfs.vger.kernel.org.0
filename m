Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13443974CF
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jun 2021 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhFAOCx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 10:02:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58450 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhFAOCv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 10:02:51 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 825811FD2A;
        Tue,  1 Jun 2021 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622556069;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=E51+eO/Nxu3Oo26uq9T8NyKM7C+S36Epnqlh8wJmUw8=;
        b=RgYs27RnCeDra2TvI7hgtWhLaqnMcLgLu6Y6cBMskHzbQEU8e1lew0HCrI++1+BkmOJRE1
        EECcog/9/JVmPwvwk6WqOJ0yxjrGbtq4PQRu5Uzvw7qdMHNkePIhwTu8SLIPiyDHMcMDSs
        T7gY5XTIMogTPUPPEvfvWlLL/dMIk/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622556069;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=E51+eO/Nxu3Oo26uq9T8NyKM7C+S36Epnqlh8wJmUw8=;
        b=oxjqM9g1RHfMJmcvDn5mamQWMbrX4Cn6/YlEKyZC5O2H93oFOCmm4URrHFnE0yxYpbJu6+
        hxxjQUB3T2oE8kAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 58D85118DD;
        Tue,  1 Jun 2021 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622556069;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=E51+eO/Nxu3Oo26uq9T8NyKM7C+S36Epnqlh8wJmUw8=;
        b=RgYs27RnCeDra2TvI7hgtWhLaqnMcLgLu6Y6cBMskHzbQEU8e1lew0HCrI++1+BkmOJRE1
        EECcog/9/JVmPwvwk6WqOJ0yxjrGbtq4PQRu5Uzvw7qdMHNkePIhwTu8SLIPiyDHMcMDSs
        T7gY5XTIMogTPUPPEvfvWlLL/dMIk/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622556069;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=E51+eO/Nxu3Oo26uq9T8NyKM7C+S36Epnqlh8wJmUw8=;
        b=oxjqM9g1RHfMJmcvDn5mamQWMbrX4Cn6/YlEKyZC5O2H93oFOCmm4URrHFnE0yxYpbJu6+
        hxxjQUB3T2oE8kAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gG+XFKU9tmDgGgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Tue, 01 Jun 2021 14:01:09 +0000
Date:   Tue, 1 Jun 2021 16:01:08 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Yong Sun <yosun@suse.com>
Subject: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
Message-ID: <YLY9pKu38lEWaXxE@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

I've also find different failures on NFS 4.0:

SEC7     st_secinfo.testRPCSEC_GSS                                : FAILURE
           SECINFO returned mechanism list without RPCSEC_GSS

LOCK24   st_lock.testOpenUpgradeLock                              : FAILURE
           OP_LOCK should return NFS4_OK, instead got
           NFS4ERR_BAD_SEQID

They're on stable kernel 5.12.3-1-default (openSUSE). I saw them also on older
kernel 4.19.0-16-amd64 (Debian).

Any idea how to find whether are these are wrong setup or test bugs or real
kernel bugs?

Upstreaming your scripts or better documenting the setup would be great.

Kind regards,
Petr
