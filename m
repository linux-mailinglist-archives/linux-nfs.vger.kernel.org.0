Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7A3EA9FB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 20:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhHLSNy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 14:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237335AbhHLSNy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 14:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628792008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H/En9nn2v1wHiOsCAMo7TJwj+SuGQu8qzbS42nEkL3I=;
        b=ZXiGiT1d7xtVvX7NPFFcq90VCCe8coAcUYWL1zp7wvWeSSxEfHBfTgG6g4mNisHEo5OV98
        7rVPMNWiJcx6MJ3DBXQzBjsQJHmxDyEoxbLiPoCz7lnsbq9GPNnkUMIoGa/q3r8xJwAJkI
        gwzhsFJ1KObmyn8Ua1RjfRglp4ayX74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-GK9t_YPxOX6MduHlzpTClw-1; Thu, 12 Aug 2021 14:13:26 -0400
X-MC-Unique: GK9t_YPxOX6MduHlzpTClw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86629760C5
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 18:13:24 +0000 (UTC)
Received: from ajmitchell.com (unknown [10.39.192.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8236B18AD4;
        Thu, 12 Aug 2021 18:13:23 +0000 (UTC)
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Alice Mitchell <ajmitchell@redhat.com>
Subject: [PATCH 0/4 v2] nfs-utils: A series of memory fixes
Date:   Thu, 12 Aug 2021 19:13:15 +0100
Message-Id: <20210812181319.3885781-1-ajmitchell@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v2
Taking into consideration the comments and suggstions made
corrected patch files.

v1
This series of patches fix a number of potential memory leaks
and memory errors within nfs-utils that mostly happen under
various error conditions.

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>

Alice Mitchell (4):
  nfs-utils: Fix potential memory leaks in idmap
  nfs-utils: Fix mem leaks in gssd
  nfs-utils: Fix mem leaks in krb5_util
  nfs-utils: Fix mem leak in mountd

 support/nfsidmap/nss.c   |  6 ++----
 support/nfsidmap/regex.c |  1 +
 utils/gssd/gssd.c        | 10 +++++-----
 utils/gssd/krb5_util.c   | 14 ++++++++++++--
 utils/mountd/rmtab.c     |  3 +++
 5 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.27.0

