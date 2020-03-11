Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93CC181C2D
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 16:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgCKPVE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 11:21:04 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:42858 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgCKPVE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 11:21:04 -0400
Received: by mail-yw1-f54.google.com with SMTP id v138so2316567ywa.9
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qH7dDDJa9xZ2SL146x8WtgndICtmvsjuacaWqQt/T7I=;
        b=qoJuR21q4I53t5TIkzd5wMArWE48WedptQYggYn5pu3i1I1jKLw4aaLa+h9lBtp3Nl
         hrzS4sydYYXXZ8LJmfAWpdlSyd4LHI2zrL/xRd/Cr5H+C+/Mew7i7PmRgIcA2Tz2S0cR
         hzlQaU86GJX0387zplXMHt7COUUIfxiZKnpOobapXT0fI+NcQwe7GHrRO5W8Vgn/qwS+
         0V4FWOfZV8kFR42ifJzJuK1geLMG2xfJjEtUI/6fZ8eebxpsPt1fECx/PqCyW2RoqN1X
         MeCvnxlIMG/v7dYc+m9j/C2ZaLzsTH8i8LPhS0zYhxxJnm+mckm5gw2wPtO4x/PBmQos
         rsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qH7dDDJa9xZ2SL146x8WtgndICtmvsjuacaWqQt/T7I=;
        b=JsbJQowX2TettLDRKRtXjTmH/j67/KF2t2ariTs1iHGqbGjiHZlRdKlEeca4BWe71X
         33JPse8vn+7KJs+JA16MmlxB2GSd6vkKGAKk5jKYWC8ryBYDuterOnk/FI2ngv1Vjf18
         V3bH4jUuKIIyQYxL7twaAKlUuolshlzVvy1EDJnnjXl8HHkVAZpHtXCvRWLnOkv2BO/0
         ZX1i5Zk/k3HItr2uE4v+SXUd5xS8Tp3Q5qGfTn6BklpBDj8vx4DHzquUNaHKkWFcEBil
         3VCuMfepa4Tmb8cNRvfTZSGO/ryyAbpzyQEHzZE8K19gdRW4wPN578tG71l7uTOkZE1H
         Kb4A==
X-Gm-Message-State: ANhLgQ128OYA+DDzJIvzI+iL+gYAcZbCa78toWWOtL+Wvdm4RkNF9mJp
        2l0XQZcBXjUpYnWTsn1CsNe+OfV38m8=
X-Google-Smtp-Source: ADFU+vuFtuM9/45sVCL6k2hbEOw/oMUHAwZlD06DAacYqcHeTuXggH8JHBjmoLzp8NmJFme2qhZtxA==
X-Received: by 2002:a5b:406:: with SMTP id m6mr3627009ybp.404.1583940063514;
        Wed, 11 Mar 2020 08:21:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x18sm14119754ywg.19.2020.03.11.08.21.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 08:21:02 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02BFL1uE014814
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 15:21:01 GMT
Subject: [PATCH v3 0/3] Fix gss_unwrap_resp_integ() again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 11 Mar 2020 11:21:01 -0400
Message-ID: <20200311151853.24642.92772.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Changes since v2:
- Remove over-aggressive length sanity check

Changes since v1:
- Reviewed-by: Ben Coddington <bcodding@redhat.com>
- Revised patch description of PATCH 1/3
- Split out stack diet change into a separate patch

---

Chuck Lever (3):
      sunrpc: Fix gss_unwrap_resp_integ() again
      SUNRPC: Remove xdr_buf_read_mic()
      SUNRPC: Trim stack utilization in the wrap and unwrap paths


 include/linux/sunrpc/xdr.h     |    1 
 net/sunrpc/auth_gss/auth_gss.c |   91 +++++++++++++++++++++++++++++-----------
 net/sunrpc/xdr.c               |   55 ------------------------
 3 files changed, 66 insertions(+), 81 deletions(-)

--
Chuck Lever
