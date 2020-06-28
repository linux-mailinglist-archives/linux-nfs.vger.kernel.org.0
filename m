Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3920C20C9D7
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jun 2020 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgF1TKP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Jun 2020 15:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgF1TKP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Jun 2020 15:10:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F21C03E979
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 12:10:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id rk21so14486790ejb.2
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8903YLQ1rIwqRAQbysd9VVqtW87VpYeZxwAfqymplTs=;
        b=FqfI382rJ8+TyBAZmaI8Umm8MUhLXjEGoeNyzaGiBAiXBoePy+skDUs7QUtwRzkWwf
         uR+kxpFnXnvMq0uuh6EkdAd6JG/l233bIMZq9lUlPhDL9TPH3rSVU7lGucZpgmPoUseu
         7Deu4eg4dGSboFXecn7SK9YvJxTgyX0ZlmqXOPGtia1qtrbz+ksaAnh4nuPgGpuK/MxX
         kZYLxXam3eIvA7+VGBsE/4ZIzf88Wc8CKUHjHjAzXBTFBJah3vOmvecUn9xX6jny1TFp
         0405SuqI8OuEbpJNoj/32IZIcIKViF1tPrsMH4F0fLmeiCg2lBWT7LptNg1/4ocMjKsZ
         8+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8903YLQ1rIwqRAQbysd9VVqtW87VpYeZxwAfqymplTs=;
        b=VVWb6qQbyVI0z3ywh1uCjL/YPFAAaCbszNYDAPLmMqQg2HdBmuSZUJPiIa6EQ2ZkLg
         R3KMx+2o6jTkoNwBhEtfkoWJPzm0WCOsA/Zz0M6VcAYwyvprmA2dMtm2Zkxda+sIy/4u
         OIAIvdoufpQovhzHzEfPWw2OZ6fcLM7Gyr5ywrbkTQ+7luZCktvwAh4RU11beSjOBaOV
         XSMwpBQGy/kpLNtsu0uYG9aopYgndJvyMGml55Hvw94G0CaoY0po6030QUbPoQ9oeGu8
         CknIecZ3J03rjKaZUZ11+2Zm/ZRkXizEF/96rc4T8apIAhv2D2/vB4Rnf5pThIqQF0Nx
         Npvg==
X-Gm-Message-State: AOAM530JKZsX1ZiUr7POoDu8P1ZLfCttMX99MCJPVB2ulcqz2W814APV
        CAMDYngq5/kNV/TeX9PToQI=
X-Google-Smtp-Source: ABdhPJxHvwrdBg5hNDpm3fQolYjua5jJEydNhiFy3rFW8fNsaPBUEH69NxahQnPSVoZIaBUwcf+FSQ==
X-Received: by 2002:a17:906:50b:: with SMTP id j11mr10871186eja.127.1593371413858;
        Sun, 28 Jun 2020 12:10:13 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id j24sm1090102edp.22.2020.06.28.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 12:10:12 -0700 (PDT)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Scott Mayhew <smayhew@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 2/2] systemd generators: Install depending on location for systemd unit files
Date:   Sun, 28 Jun 2020 21:10:02 +0200
Message-Id: <20200628191002.136918-3-carnil@debian.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628191002.136918-1-carnil@debian.org>
References: <20200628191002.136918-1-carnil@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While it is possible to configure the systemd unit files directory on
configure time with --with-systemd=unit-dir-path, this path is not taken
into account for installing the systemd unit generators, as they are
installed unconditionally in /usr/lib/systemd/system-generators.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 systemd/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index f089c8831902..9ee4f1c8f967 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -45,7 +45,7 @@ man5_MANS	= nfs.conf.man
 man7_MANS	= nfs.systemd.man
 EXTRA_DIST = $(unit_files) $(man5_MANS) $(man7_MANS)
 
-generator_dir = /usr/lib/systemd/system-generators
+generator_dir = $(unitdir)/../system-generators
 
 EXTRA_PROGRAMS	= nfs-server-generator rpc-pipefs-generator
 genexecdir = $(generator_dir)
-- 
2.27.0

