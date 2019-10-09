Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E62D14B4
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfJIQ6F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 12:58:05 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:34010 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIQ6F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 12:58:05 -0400
Received: by mail-io1-f54.google.com with SMTP id q1so6653353ion.1
        for <linux-nfs@vger.kernel.org>; Wed, 09 Oct 2019 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TzDFGRkt4V+c3ZpweRkJ0SJyocuAel5BYydeMS6UFJw=;
        b=PvnqUYuXfhuxV5DWKZX2vUjXCiT54XImPcXLoJVFmJJMc75ZYDWALDpGK/OQ53GjfL
         92OTID2i6+/jPlhJ9vz9sS8+jN0+j6AzahtiNf58cpSiq0rFUECtke4NtUPc+DgmoR9G
         hY27nHIFpbJ20iQU3GO9ToRINlDv8pwbMdHSGbHZLiLB7XQKsZsRAKN6Ap5B9EK1HLBB
         sI5yviZdt+Q3diO3VHVsSZ9xcSZJbbeJZ+sHDUIqeUr+bhU+HNrYYhPXKXVN069VDQr7
         gzyqgiSkI6KRtXl78L7fcwBCxxtu5TIVmxMpQRYwi5L53EXzxR7Xtjy+j8UUwNe6NJ+z
         fEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TzDFGRkt4V+c3ZpweRkJ0SJyocuAel5BYydeMS6UFJw=;
        b=aTzixjWPEBdPG1IACQdhwXVrvCBp5kTSUBXbdSZ/PVfLn19YmXbB0oAYRboG1ETa6p
         Ksg+ppghI8VI7B666f9Wt/pubTRVVrfFxm+8enKcrNM7oBaL+k9qvJLBPM+1ZD/oajtf
         mRIsH47sUpH6/Hoy3eNhoSKeNcZlD/H09Jur/ojnvqXcGkJN4A5W/hZboSC+t5tSNqpW
         NXCtg6KfRVovG4IJDhmfRGYlDCVBjiOkAPy0O+a9GLNuDkZ1SiQPbvTAXkKUwhuL7YAq
         COXJVIN/Wqe1RF3JRHhhmXWR8eodb2MgEXcerSMwl5iACjQYjmsAWSuVrG6rTeiBMQOo
         ywyg==
X-Gm-Message-State: APjAAAXMRE2M7B0FGRN942MFgo8JVZe/YOTeetH9hdBy/orUJgoTULud
        lRL25yJYA4LjS6/8aqbHkcIOyXFc
X-Google-Smtp-Source: APXvYqwE6+bV5lSPurvYP8i+mcJ5XOznY0Pt4khp/nR9zJuCqFb/k3ed6/K26Ack/T7PSyd+qwFXoQ==
X-Received: by 2002:a05:6638:632:: with SMTP id h18mr4178164jar.55.1570640284734;
        Wed, 09 Oct 2019 09:58:04 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q74sm1621918iod.72.2019.10.09.09.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 09:58:04 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x99Gw2l8001452;
        Wed, 9 Oct 2019 16:58:02 GMT
Subject: [PATCH 0/2] Two quick clean-ups
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 09 Oct 2019 12:58:02 -0400
Message-ID: <20191009165713.2428.84819.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

Please consider these kernel RPC client patches for v5.5. Thanks!

---

Chuck Lever (2):
      SUNRPC: Eliminate log noise in call_reserveresult
      SUNRPC: Add trace points to observe transport congestion control


 include/trace/events/sunrpc.h |   93 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/clnt.c             |   14 +-----
 net/sunrpc/xprt.c             |   22 ++++++----
 3 files changed, 108 insertions(+), 21 deletions(-)

--
Chuck Lever
