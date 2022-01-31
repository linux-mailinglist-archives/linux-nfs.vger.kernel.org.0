Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659EB4A4F0F
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 19:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358744AbiAaS6B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jan 2022 13:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358833AbiAaS5q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 13:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643655465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oXtMZkUkvrgyWY3ORHNkYE0XqNRKdArTE3bzzRFmsfc=;
        b=M/5tIwxFbH730blBxnX+S5sAVoN6E7G65wedr8rd/O3Ed0bJq5/OtRBBQvgCrcNZT4Wut+
        DWQWqx0pRgsDW/cxKA6yiMU37fTGX+mg5aTYK9NMW7WRL3gGy7f2fr6yn11kgUtKivZ/Fb
        NVnBnkFuD2hMX8YDWIdIzfRArrk2Kb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-xKKkJa5ZOzWGjmcaNKWsLQ-1; Mon, 31 Jan 2022 13:57:39 -0500
X-MC-Unique: xKKkJa5ZOzWGjmcaNKWsLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA4F86A8A6;
        Mon, 31 Jan 2022 18:57:38 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 029EE7A441;
        Mon, 31 Jan 2022 18:57:38 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 3FE5E1A001F; Mon, 31 Jan 2022 13:57:37 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] selinux: parse sids earlier to avoid doing memory allocations under spinlock
Date:   Mon, 31 Jan 2022 13:57:35 -0500
Message-Id: <20220131185737.1640824-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
shouldn't be performing any memory allocations. 

The first patch fixes this by parsing the sids at the same time the
context mount options are being parsed from the mount options string
and storing the parsed sids in the selinux_mnt_opts struct. 

The second patch adds logic to selinux_set_mnt_opts() and
selinux_sb_remount() that checks to see if a sid has already been
parsed before calling parse_sid(), and adds the parsed sids to the
data being copied in selinux_fs_context_dup().

Scott Mayhew (2):
  selinux: Fix selinux_sb_mnt_opts_compat()
  selinux: try to use preparsed sid before calling parse_sid()

 security/selinux/hooks.c | 147 ++++++++++++++++++++++++---------------
 1 file changed, 92 insertions(+), 55 deletions(-)

-- 
2.31.1

