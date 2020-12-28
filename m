Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF92E6989
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Dec 2020 18:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgL1REd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Dec 2020 12:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgL1REc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Dec 2020 12:04:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5370C0613D6
        for <linux-nfs@vger.kernel.org>; Mon, 28 Dec 2020 09:03:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u19so10353851edx.2
        for <linux-nfs@vger.kernel.org>; Mon, 28 Dec 2020 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3LlD+dScTbPaJ7b9z6fQ7/W16eGNy+ofmIXcLIypBE4=;
        b=MqG+igwfjYxnFkwXJnDAGnGyjl4gGZ6932hxWGR8X/C5QXvKhuj5MQxONF9lmPhriD
         j3POBtjILt3V8DzoPzcuZMzdknPcCKRl0vd+kYFszwJrYc0c3OcFbBezbyTWmnKmjNIC
         Wl/wcY2JsXpRxOIl4h6Ukpab3I8R5sEl7Aqlejih15wYC0OA3vEqZ3Mr8m9eDYezywVw
         rFLrJgZxN78C0BCBqT/4qXSOUUT7hm0srYDCI8hWR0nXvPnXNccLVlurw7o2NTuZ9Qgl
         ai6BKnGWH5eC/xXILMfzQR9+CLVC6NncTXAQpc3cg4WEuYo0Z8mh0opplkJ/joAKUXhx
         dvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3LlD+dScTbPaJ7b9z6fQ7/W16eGNy+ofmIXcLIypBE4=;
        b=XZFOf5ovRUxAQwZfSZKbXSJTAUZocqlVTu8KHerQkwp4dmAWpbXFmurqscVK28Gs/C
         XcK7wf4f+PpWvgUePW6d8wjU6TDusDSzZOasX8p+4aiNRdwMmA+u9aRpbrJTIacyhr8p
         olnJEcY1gyGjVa+27ckLrv7JV048xzxDi/kd0SGduFlrdRCvptOcWjrQG7SuQku5lAGo
         hWnZSuXo3EeL5IpcLg6c5Fax46WGGYd/Sa2pJv9ZoaPpoGQx0p+i9HmMqaI1D/fV4hB2
         sStgHX0DymZhuQV0q1XhRYC4QYQQYXTTeCnBD0e1YVEe0Xg8JFYuKNDkqDgwXZncRNgd
         e3Ew==
X-Gm-Message-State: AOAM532AsDh3tkrQRLVU9JqM+EZpbB+hby0bmsgPVf28dENFVh67qo+g
        EqimpXpNgcdK/d8jqzBRxEQn3OhsL1M=
X-Google-Smtp-Source: ABdhPJz2R75Zlm+k6NTnaRJblr83xR3NJByVYE+fU2fQGjXKS5yPoBmwuxohNxc6zgk7695IggXqHQ==
X-Received: by 2002:aa7:c698:: with SMTP id n24mr42897159edq.277.1609175030630;
        Mon, 28 Dec 2020 09:03:50 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id i15sm17417082ejj.28.2020.12.28.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 09:03:50 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Improvements to nfsd stats
Date:   Mon, 28 Dec 2020 19:03:42 +0200
Message-Id: <20201228170344.22867-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

The original motivation for this work was to add per-export stats.
While doing so, I noticed that most nfsd stats variables are not
protected against concurrent update, so fixed that first.

There are still a couple stats variables (longest_chain*) that are
not counters so less trivial to fix. I did not touch them.

There is also an eyebrow raising number of variabled in nfsd_stats
struct that are never updated. I did not touch those either.
If you want me to send a cleanup patch to remove them and print
hardcoded zeroes in the nfsd stats file I can do that.

Thanks,
Amir.

Amir Goldstein (2):
  nfsd: protect concurrent access to nfsd stats counters
  nfsd: report per-export stats

 fs/nfsd/export.c   | 68 +++++++++++++++++++++++++++++++-----
 fs/nfsd/export.h   | 17 +++++++++
 fs/nfsd/netns.h    | 20 +++++++----
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfscache.c | 52 +++++++++++++++++++--------
 fs/nfsd/nfsctl.c   |  8 ++++-
 fs/nfsd/nfsfh.c    |  9 +++--
 fs/nfsd/stats.c    | 87 ++++++++++++++++++++++++++++++++++++----------
 fs/nfsd/stats.h    | 42 +++++++++++++++-------
 fs/nfsd/vfs.c      |  6 ++--
 10 files changed, 243 insertions(+), 68 deletions(-)

-- 
2.17.1

