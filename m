Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A147C7BF7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 05:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjJMDZZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 23:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDZY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 23:25:24 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CBAFA9;
        Thu, 12 Oct 2023 20:25:22 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 11:23:40
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 11:23:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: Clean up errors in nfs_fs_sb.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <11c6beae.946.18b270fac0f.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD48uChlgdjBAA--.623W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQARsV
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
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
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvbmZzX2ZzX3NiLmgg
fCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9uZnNfZnNf
c2IuaCBiL2luY2x1ZGUvbGludXgvbmZzX2ZzX3NiLmgKaW5kZXggY2Q2MjhjNGIwMTFlLi4wMzEx
MTc4Y2IxMzcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbmZzX2ZzX3NiLmgKKysrIGIvaW5j
bHVkZS9saW51eC9uZnNfZnNfc2IuaApAQCAtNTEsMjAgKzUxLDIwIEBAIHN0cnVjdCBuZnNfY2xp
ZW50IHsKICNkZWZpbmUgTkZTX0NTX1BORlMJCTkJCS8qIC0gU2VydmVyIHVzZWQgZm9yIHBuZnMg
Ki8KIAlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZQljbF9hZGRyOwkvKiBzZXJ2ZXIgaWRlbnRpZmll
ciAqLwogCXNpemVfdAkJCWNsX2FkZHJsZW47Ci0JY2hhciAqCQkJY2xfaG9zdG5hbWU7CS8qIGhv
c3RuYW1lIG9mIHNlcnZlciAqLwotCWNoYXIgKgkJCWNsX2FjY2VwdG9yOwkvKiBHU1NBUEkgYWNj
ZXB0b3IgbmFtZSAqLworCWNoYXIgICAgICAgICAgICAgICAgICAgKmNsX2hvc3RuYW1lOwkvKiBo
b3N0bmFtZSBvZiBzZXJ2ZXIgKi8KKwljaGFyICAgICAgICAgICAgICAgICAgICpjbF9hY2NlcHRv
cjsJLyogR1NTQVBJIGFjY2VwdG9yIG5hbWUgKi8KIAlzdHJ1Y3QgbGlzdF9oZWFkCWNsX3NoYXJl
X2xpbms7CS8qIGxpbmsgaW4gZ2xvYmFsIGNsaWVudCBsaXN0ICovCiAJc3RydWN0IGxpc3RfaGVh
ZAljbF9zdXBlcmJsb2NrczsJLyogTGlzdCBvZiBuZnNfc2VydmVyIHN0cnVjdHMgKi8KIAotCXN0
cnVjdCBycGNfY2xudCAqCWNsX3JwY2NsaWVudDsKKwlzdHJ1Y3QgcnBjX2NsbnQgICAgICAgICpj
bF9ycGNjbGllbnQ7CiAJY29uc3Qgc3RydWN0IG5mc19ycGNfb3BzICpycGNfb3BzOwkvKiBORlMg
cHJvdG9jb2wgdmVjdG9yICovCiAJaW50CQkJY2xfcHJvdG87CS8qIE5ldHdvcmsgdHJhbnNwb3J0
IHByb3RvY29sICovCi0Jc3RydWN0IG5mc19zdWJ2ZXJzaW9uICoJY2xfbmZzX21vZDsJLyogcG9p
bnRlciB0byBuZnMgdmVyc2lvbiBtb2R1bGUgKi8KKwlzdHJ1Y3QgbmZzX3N1YnZlcnNpb24gICpj
bF9uZnNfbW9kOwkvKiBwb2ludGVyIHRvIG5mcyB2ZXJzaW9uIG1vZHVsZSAqLwogCiAJdTMyCQkJ
Y2xfbWlub3J2ZXJzaW9uOy8qIE5GU3Y0IG1pbm9ydmVyc2lvbiAqLwogCXVuc2lnbmVkIGludAkJ
Y2xfbmNvbm5lY3Q7CS8qIE51bWJlciBvZiBjb25uZWN0aW9ucyAqLwogCXVuc2lnbmVkIGludAkJ
Y2xfbWF4X2Nvbm5lY3Q7IC8qIG1heCBudW1iZXIgb2YgeHBydHMgYWxsb3dlZCAqLwotCWNvbnN0
IGNoYXIgKgkJY2xfcHJpbmNpcGFsOwkvKiB1c2VkIGZvciBtYWNoaW5lIGNyZWQgKi8KKwljb25z
dCBjaGFyICAgICAgICAgICAgICpjbF9wcmluY2lwYWw7CS8qIHVzZWQgZm9yIG1hY2hpbmUgY3Jl
ZCAqLwogCXN0cnVjdCB4cHJ0c2VjX3Bhcm1zCWNsX3hwcnRzZWM7CS8qIHhwcnQgc2VjdXJpdHkg
cG9saWN5ICovCiAKICNpZiBJU19FTkFCTEVEKENPTkZJR19ORlNfVjQpCkBAIC04MiwxMCArODIs
MTAgQEAgc3RydWN0IG5mc19jbGllbnQgewogCXN0cnVjdCBycGNfd2FpdF9xdWV1ZQljbF9ycGN3
YWl0cTsKIAogCS8qIGlkbWFwcGVyICovCi0Jc3RydWN0IGlkbWFwICoJCWNsX2lkbWFwOworCXN0
cnVjdCBpZG1hcCAgICAgICAgICAgKmNsX2lkbWFwOwogCiAJLyogQ2xpZW50IG93bmVyIGlkZW50
aWZpZXIgKi8KLQljb25zdCBjaGFyICoJCWNsX293bmVyX2lkOworCWNvbnN0IGNoYXIgICAgICAg
ICAgICAgKmNsX293bmVyX2lkOwogCiAJdTMyCQkJY2xfY2JfaWRlbnQ7CS8qIHY0LjAgY2FsbGJh
Y2sgaWRlbnRpZmllciAqLwogCWNvbnN0IHN0cnVjdCBuZnM0X21pbm9yX3ZlcnNpb25fb3BzICpj
bF9tdm9wczsKQEAgLTEzMCwxNCArMTMwLDE0IEBAIHN0cnVjdCBuZnNfY2xpZW50IHsKICAqIE5G
UyBjbGllbnQgcGFyYW1ldGVycyBzdG9yZWQgaW4gdGhlIHN1cGVyYmxvY2suCiAgKi8KIHN0cnVj
dCBuZnNfc2VydmVyIHsKLQlzdHJ1Y3QgbmZzX2NsaWVudCAqCW5mc19jbGllbnQ7CS8qIHNoYXJl
ZCBjbGllbnQgYW5kIE5GUzQgc3RhdGUgKi8KKwlzdHJ1Y3QgbmZzX2NsaWVudCAgICAgICpuZnNf
Y2xpZW50OwkvKiBzaGFyZWQgY2xpZW50IGFuZCBORlM0IHN0YXRlICovCiAJc3RydWN0IGxpc3Rf
aGVhZAljbGllbnRfbGluazsJLyogTGlzdCBvZiBvdGhlciBuZnNfc2VydmVyIHN0cnVjdHMKIAkJ
CQkJCSAqIHRoYXQgc2hhcmUgdGhlIHNhbWUgY2xpZW50CiAJCQkJCQkgKi8KIAlzdHJ1Y3QgbGlz
dF9oZWFkCW1hc3Rlcl9saW5rOwkvKiBsaW5rIGluIG1hc3RlciBzZXJ2ZXJzIGxpc3QgKi8KLQlz
dHJ1Y3QgcnBjX2NsbnQgKgljbGllbnQ7CQkvKiBSUEMgY2xpZW50IGhhbmRsZSAqLwotCXN0cnVj
dCBycGNfY2xudCAqCWNsaWVudF9hY2w7CS8qIEFDTCBSUEMgY2xpZW50IGhhbmRsZSAqLwotCXN0
cnVjdCBubG1faG9zdAkJKm5sbV9ob3N0OwkvKiBOTE0gY2xpZW50IGhhbmRsZSAqLworCXN0cnVj
dCBycGNfY2xudCAgICAgICAgKmNsaWVudDsJCS8qIFJQQyBjbGllbnQgaGFuZGxlICovCisJc3Ry
dWN0IHJwY19jbG50ICAgICAgICAqY2xpZW50X2FjbDsJLyogQUNMIFJQQyBjbGllbnQgaGFuZGxl
ICovCisJc3RydWN0IG5sbV9ob3N0CSAgICAgICAqbmxtX2hvc3Q7CS8qIE5MTSBjbGllbnQgaGFu
ZGxlICovCiAJc3RydWN0IG5mc19pb3N0YXRzIF9fcGVyY3B1ICppb19zdGF0czsJLyogSS9PIHN0
YXRpc3RpY3MgKi8KIAlhdG9taWNfbG9uZ190CQl3cml0ZWJhY2s7CS8qIG51bWJlciBvZiB3cml0
ZWJhY2sgcGFnZXMgKi8KIAl1bnNpZ25lZCBpbnQJCXdyaXRlX2Nvbmdlc3RlZDsvKiBmbGFnIHNl
dCB3aGVuIHdyaXRlYmFjayBnZXRzIHRvbyBoaWdoICovCi0tIAoyLjE3LjEK
