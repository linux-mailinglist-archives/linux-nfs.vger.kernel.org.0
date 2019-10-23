Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1ADE2245
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbfJWSCV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 14:02:21 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:43142 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387653AbfJWSCU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 14:02:20 -0400
Received: by mail-il1-f170.google.com with SMTP id t5so19757421ilh.10
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tbrAqISD0A1XNfccc8GtyRMc1VT7DwQh2P5wT+Wa2Eo=;
        b=AjOzBhj0dkjTnB1vObINeCkDIQVwVcYl1rsrjDWv3BtqaQ0OwS5RkLWeSdWKjrWP0A
         +gHfg4Vkbz5vTOP+uR+KlfIk9m58qvxn/oY04gMPLKgz/wUlq741zqVPSCbjhF2pTurT
         w9uHWzyws+yCw5B+V65remmXpQrcVqScwnlEyXPa4cn7l3TrhDPrws2Ebk6FxfdqmvYR
         6F8Fn5YhYTY4sPi6aTvy9ucg+29TNAyyaNZKUJWIKFJ+KZ7M4EcMZ6M6I1xfldl8HqKU
         b2QuwD/G3KtaGp3ccMpVH0XhSaxpOH1Il+5TERzhU3wSluvD9DdblK2bD/uT4QgnXeEe
         UKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tbrAqISD0A1XNfccc8GtyRMc1VT7DwQh2P5wT+Wa2Eo=;
        b=lQRn+eKR+tvFEdqFN+Cqbdz/FNBd1tkl51GF5AxoJhqVGOO7PsWA6hdjFjW8VSz1Vx
         7Esn46GTn4t9mGUmBl/9HiLFUp2wAxVaDoDnRwYEgqHQYxxAC5n9ZOkurvyS24VR3PSY
         Pd2oxAqyq5DxMYz16skSP/K/HsM/nptsFZHrrmggSvhuKOVn32TvJvcOdrswLiq+fKIX
         7TW2QfxHBeUtPOeKpWSSBRn9JmoodMnjHv2vcWloI99VoB1KjcMC8JSZUdvSApvc6Oxb
         gOEjHG+SKR+kU9Opdm38kiPUl2zAcv9ZTkUIVMUMJKJzo8l6xvPktbgF7LbCX0SNO/Qk
         2/1Q==
X-Gm-Message-State: APjAAAUPCp+V+vSjMosj7fCNsfNQRRffFXzs7mrn8cnKMMG4n9efOvfS
        KsPmjPilsAenaxka6dX8Il8znBK1
X-Google-Smtp-Source: APXvYqxQaq8Nitj33lI3vHx53ASo/64xMhSUfFhdlJ0Th8NXrlIBh8pCt0AUeR/KKo5+cbc4TbI/OA==
X-Received: by 2002:a92:360b:: with SMTP id d11mr39160734ila.249.1571853739500;
        Wed, 23 Oct 2019 11:02:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i26sm7065779ion.40.2019.10.23.11.02.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 11:02:19 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9NI2HPP012953
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 18:02:18 GMT
Subject: [PATCH RFC 0/2] Possible new NFS trace events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 23 Oct 2019 14:02:17 -0400
Message-ID: <20191023180049.6450.65440.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Wondering if these additional trace points might be useful. Review
and comments welcome.

---

Chuck Lever (2):
      NFS: Introduce trace events triggered by page writeback errors
      NFS4: Report callback authentication errors


 fs/nfs/callback_xdr.c |   11 ++++++++---
 fs/nfs/nfs4trace.h    |   35 +++++++++++++++++++++++++++++++++++
 fs/nfs/nfstrace.h     |   45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/write.c        |    3 +++
 4 files changed, 91 insertions(+), 3 deletions(-)

--
Chuck Lever
