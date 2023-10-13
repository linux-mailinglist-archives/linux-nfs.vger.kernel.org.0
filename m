Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D758E7C7E14
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 08:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjJMGvD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 02:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJMGvB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 02:51:01 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4945C0;
        Thu, 12 Oct 2023 23:50:55 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 14:49:13
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 14:49:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: Clean up errors in nfstrace.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <494a6f32.95c.18b27cbdc04.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD9p6ChlS97BAA--.652W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQABB2UlHDMAlgANsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcHJvaGliaXRlZCBiZWZvcmUgdGhhdCBjbG9zZSBwYXJlbnRoZXNpcyAnKScKClNpZ25l
ZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBmcy9uZnMv
bmZzdHJhY2UuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnN0cmFjZS5oIGIvZnMvbmZzL25mc3RyYWNl
LmgKaW5kZXggNGU5MGNhNTMxMTc2Li42YzliMzJjYjYyMGQgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9u
ZnN0cmFjZS5oCisrKyBiL2ZzL25mcy9uZnN0cmFjZS5oCkBAIC0xNTI0LDcgKzE1MjQsNyBAQCBU
UkFDRV9FVkVOVChuZnNfY29tbWl0X2RvbmUsCiAJCQl7IE5GU19PRElSRUNUX0RPX0NPTU1JVCwg
IkRPX0NPTU1JVCIgfSwgXAogCQkJeyBORlNfT0RJUkVDVF9SRVNDSEVEX1dSSVRFUywgIlJFU0NI
RURfV1JJVEVTIiB9LCBcCiAJCQl7IE5GU19PRElSRUNUX1NIT1VMRF9ESVJUWSwgIlNIT1VMRCBE
SVJUWSIgfSwgXAotCQkJeyBORlNfT0RJUkVDVF9ET05FLCAiRE9ORSIgfSApCisJCQl7IE5GU19P
RElSRUNUX0RPTkUsICJET05FIiB9KQogCiBERUNMQVJFX0VWRU5UX0NMQVNTKG5mc19kaXJlY3Rf
cmVxX2NsYXNzLAogCQlUUF9QUk9UTygKLS0gCjIuMTcuMQo=
