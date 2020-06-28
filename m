Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB18820C9D5
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jun 2020 21:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgF1TKI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Jun 2020 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgF1TKH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Jun 2020 15:10:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2377C03E979
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 12:10:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e22so11061822edq.8
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rkkr3wVXccfProQobyaDOowLtuXZjb8pyyBu/kzM+WA=;
        b=JcyV/U3TK0IYp7OE3OErK+JrsqSiqqmgTm2EYrZjqiEEKFJRGTtVYBF/nBEAwNfHpM
         1kyAmN1S1QRH0K29EXwSFB6mmQtiR7aVepV2gvysZXGT8N2EygbKyfwmE40Bx006L4iN
         5eQZv11NnDk6Alf1I6YDRi8IppbE/a3N8TtTQ4puoDe02VEcMXlefqejWySIaQrHQbay
         joizsJmloZA1HhPNKBgcz/dfl+1BJVuRRkTio1ltBC9Dwyuzc+OKkyH9pizGsdCnJ1II
         Nagi5SobYTQBpOiSsBthk4WqYOstfOYcfF4BEwdtWe9aiIbHxMa84+JSuPWhDioqXkOc
         JEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Rkkr3wVXccfProQobyaDOowLtuXZjb8pyyBu/kzM+WA=;
        b=E+vf8sqoPy82Tj6AmKFyGIGetFt31YU4UBI1F0PejYuPITrZqJNLpza+OfbAslsH/3
         YPwEEXj+SuBqG65CNU1ZqarPIS51jGN9KDTjW+3LZgcAZh5ZZ25uWrguMuTjzlpSaK7k
         dWvVGZbeglGqKnQjaTYbevh5PLbDgluzBo4DjA/PVm78AJGbXzHd+4pTP1zr4wlifbq3
         BfnAHzd36xgGw487wUERFKHr/FZoCJfPUuE55VfsI98c3rTXmAwNZJ9Zlnat/5DiqbXL
         MH+98vkUal12V+a3bOaN1tQGhl524vR7COnQFY7TDMXZC0i9vaGfQUxCd4Cw0o8rv0xx
         MD+Q==
X-Gm-Message-State: AOAM531+UkHq0uc2qbRdUBforH5kkIXGhR3OYHSk1YsjvBzC2AtJXMWO
        AG/NkwWnUXoPBKsMAe2XDqg=
X-Google-Smtp-Source: ABdhPJxwDxLyW+Mkn/cehl0bxWyhITf2jKmPZTUYrx1dqf9+MvHdRkKh9IPFFgD2n0sQeRI+0GFKGw==
X-Received: by 2002:aa7:d7d0:: with SMTP id e16mr13699307eds.10.1593371405912;
        Sun, 28 Jun 2020 12:10:05 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id w18sm5327024ejc.62.2020.06.28.12.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 12:10:05 -0700 (PDT)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Scott Mayhew <smayhew@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 0/2] Allow to to install systemd generators dependend on --with-systemd unit-dir-path location
Date:   Sun, 28 Jun 2020 21:10:00 +0200
Message-Id: <20200628191002.136918-1-carnil@debian.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently --with-systemd=unit-dir-path would be ignored to install the
systemd generators and they are unconditionally installed in
/usr/lib/systemd/system-generators . Distributions installing systemd
unit files in /lib/systemd/system would though install the
systemd-generators in /lib/systemd/system-generators.

Make the installation of the systemd unit generators relative depending
on the unit-dir-path passed for --with-systemd.

Salvatore Bonaccorso (2):
  systemd/Makefile: Drop exlicit setting of unit_dir
  systemd generators: Install depending on location for systemd unit
    files

 systemd/Makefile.am | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.27.0

