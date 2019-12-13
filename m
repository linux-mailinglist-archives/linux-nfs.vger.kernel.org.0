Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF35E11E553
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfLMOL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:29 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:34069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfLMOLD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mwfj0-1hm7jP0CVe-00y7RM; Fri, 13 Dec 2019 15:10:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 08/12] nfsd: fix delay timer on 32-bit architectures
Date:   Fri, 13 Dec 2019 15:10:42 +0100
Message-Id: <20191213141046.1770441-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ozu4/pW+qCLxecDh3MKrULZcF90m6hSpu021bvKefFoHkHEq9Ku
 shomPCLvJLy6Epoe1gwNj87M2yyVRlRTjcE1uGBY+fBu2xOkTAcJaqkxClVYajDllbEEsEE
 UznBhgfNHcVaIuEGBOuzRVu/h3WdhTHRdqa37WSuvJ8k+AA3Hla25u2Im4zr7eNRk5M96/C
 XW4TFyNNfbucorssE6dmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xuhYPSf0wgU=:io1itl3p42GbQW92RFBuA+
 4gnILpuRAdX4u2bzsTAQA5ODcN6kOT6oOj8/AHpZFWau6BZmM/U2pAiKFn/gvqG9qhcO8ix89
 cbA0m9fDlvBgA9g6GcjxNyzvIZ6kFEOHWwf/sfqxYeysdRE234R2v4W4DKI6zBNWKR2tMxF8y
 aObBRkAoK3lTRNznjEf5vLWGIkLeznTEEME26UMN/OlWkdCtPKmvVAdV8Q8VMFPkjAOP7a+lt
 M+ddORi4ccutIEtU7ZJmIJKZz9ho1RJapgll/ls3piNBe//DFulDSSKAos5+SdOB53NE6/yxO
 HHKXsvMJf2budQ8AVP1jOlbCW0tEgk/PAnNQ//yg1n/DfeoUxqmhheXAIgsHBd+7gdIrE0yvy
 l91HRZorgdAhUlCPonat0PN9M7HCOnWtKyWES60ZfvZ5YaPGFcRCSS/ATCkL5QZfQ/K0pxkn9
 A1A7P/hBV8V4PO7q45DulM1C8lDGo+TI4Mb5KD7RxP53/yZ7X/iAY222useB8phaDcTf5sReN
 nwcE2SQjgZb4hezlKnspbCpl8RgdetnHrjK+FoRNj0TXviClHW4IosW+gakeBGUJoEQLATPHH
 /60w7BbuqArdaxd3+M09XNBkGujPDjMvdfLCPQtzHuhNHoocndClfoHoxRPW4AWj49PfcQ2PN
 9MU88JRvfU/+A8fupAnUlXs1pJE56vyLELZCyPxKVLeksTmsrpKEdrE1pkjOSVrOiKY7kzQ+S
 oMhgwJcoWKibcSyhgRZds1GI+yFEIzJX8gI7oZNgE0l50q6miGjcJ0e7FlIRW0RJsI4ABHfS9
 PcucIbOr6HcyeslBNCzwUyaJHW/0rZZtKLelcrz6wYnz4MQn/IeeE4g6eGtTcuN7JmGyE2psx
 cMgxXcmxZ6OnldX6+30A==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfsd4_cb_layout_done() function takes a 'time_t' value,
multiplied by NSEC_PER_SEC*2 to get a nanosecond value.

This works fine on 64-bit architectures, but on 32-bit, any
value over 1 second results in a signed integer overflow
with unexpected results.

Cast one input to a 64-bit type in order to produce the
same result that we have on 64-bit architectures, regarless
of the type of nfsd4_lease.

Fixes: 6b9b21073d3b ("nfsd: give up on CB_LAYOUTRECALLs after two lease periods")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4layouts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 2681c70283ce..e12409eca7cc 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -675,7 +675,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 
 		/* Client gets 2 lease periods to return it */
 		cutoff = ktime_add_ns(task->tk_start,
-					 nn->nfsd4_lease * NSEC_PER_SEC * 2);
+					 (u64)nn->nfsd4_lease * NSEC_PER_SEC * 2);
 
 		if (ktime_before(now, cutoff)) {
 			rpc_delay(task, HZ/100); /* 10 mili-seconds */
-- 
2.20.0

