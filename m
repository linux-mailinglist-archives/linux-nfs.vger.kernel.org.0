Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AC26AC975
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Mar 2023 18:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCFRMC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Mar 2023 12:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCFRMB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Mar 2023 12:12:01 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F59865132;
        Mon,  6 Mar 2023 09:11:22 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id m4so7111892qvq.3;
        Mon, 06 Mar 2023 09:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678122590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+BGgoHDzc7+NmR0hn4rA1NNLqZTh2qEE69Q1RGzpP8=;
        b=hvReIGjzJBupBHJOehU1TDMWO1dOnGTbZNPIde2a2Jq6vgsGhwuzfwOTFgma2u5t/k
         xicXjF3V9Ja3+447N9Ok9RxKSBagblklCgQx51Jlw2sAkdSkYWZ+q4QVg2LZWjodgpqx
         mUiDhLSp7D24RCg/gdVYgmT0tPZlTZbWNNRvJzWjqYIthGI/gmwVBVGf8bd2e3zjXtyI
         /L3ZzEc/yrl9mUwi0Xx2EDboZUceIMihinbagAy3VFNSwZFyIuMJKaRyQGuN1CGWFwRQ
         F9mKaypW+bwfZpxv3c1lptFjVG9Vq8nTlmRS66a08SpOjVzHsdr15NXqoDTLNI+b8ljE
         lF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678122590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+BGgoHDzc7+NmR0hn4rA1NNLqZTh2qEE69Q1RGzpP8=;
        b=0gdqiC4G7h4fYNTRW5B10BWg9NWoEaqAopvm0QYxg8b9V4DLWmD3CCrFVgZHznoS8j
         ipZ9p9U3u002hh015zQnogjTXFMVi9fMulqomkvDPdP8DLj/oRZWbumNp49At0SMQvb+
         RWue5sY5OmOfx+qrpwO24uO8ytIujgtl7AQwUN2l7WsO2Ax0Clci2m5SZM3nN2yvSukn
         CY+hVML3GuF+fcMTpr9MdaHrzTMmxIpI9AfUAR6BGfagiNFWqzaX4kD9xF0AXF/XQVZf
         Ngbe5Uvr83YQHJpI1S+oQzs8L/4hnxRwrkPeEB5hQpTrOPkd1e0xVrXK3XgZr5AQ7Aw6
         6qoQ==
X-Gm-Message-State: AO0yUKX0h73WJflyX3QAQmE/j0g+Iu2DK+CrA6NSqEJbU3/ACVtkHWDY
        0PRFsnHPR/INvlloA92O7YcdAqhGuKWePCKZPqw=
X-Google-Smtp-Source: AK7set/dNXrM/q4DD+eq7JiFfAV/j8ceoLnDGBHikXrbmdNTN3Xbus+CPPP87DWUcfC1mb7fZBut6SeRE/I+aqLXQ4E=
X-Received: by 2002:a05:6214:913:b0:56e:ff38:46a2 with SMTP id
 dj19-20020a056214091300b0056eff3846a2mr3125460qvb.10.1678122590367; Mon, 06
 Mar 2023 09:09:50 -0800 (PST)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org> <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org> <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
 <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org> <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
 <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org> <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
 <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org> <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org>
In-Reply-To: <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 6 Mar 2023 12:09:34 -0500
Message-ID: <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000e3cadb05f63e5cc4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--000000000000e3cadb05f63e5cc4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, Feb 14, 2023 at 6:02=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/02/2023 15:05, Anna Schumaker wrote:
> >>> From ac2d6c501dbcdb306480edaee625b5496f1fb4f5 Mon Sep 17 00:00:00 200=
1
> >>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>> Date: Fri, 10 Feb 2023 15:50:22 -0500
> >>> Subject: [PATCH] NFSv4.2: Rework scratch handling for READ_PLUS
> >>>
> >>
> >> Patch is corrupted - maybe mail program reformatted it when sending:
> >>
> >> Applying: NFSv4.2: Rework scratch handling for READ_PLUS
> >> error: corrupt patch at line 12
> >> Patch failed at 0001 NFSv4.2: Rework scratch handling for READ_PLUS
> >
> > That's weird. I wasn't expecting gmail to reformat the patch but I
> > guess it did. I've added it as an attachment so that shouldn't happen
> > again.
>
> Still null ptr (built on 420b2d4 with your patch):

We're through the merge window and at rc1 now, so I can spend more
time scratching my head over your bug again. We've come up with a
patch (attached) that adds a bunch of printks to show us what the
kernel thinks is going on. Do you mind trying it out and letting us
know what gets printed out? You'll need to make sure
CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.

Thanks,
Anna

>
> [  144.690844] mmiocpy from xdr_inline_decode (net/sunrpc/xdr.c:1419 net/=
sunrpc/xdr.c:1454)
> [  144.695950] xdr_inline_decode from nfs4_xdr_dec_read_plus (fs/nfs/nfs4=
2xdr.c:1063 fs/nfs/nfs42xdr.c:1147 fs/nfs/nfs42xdr.c:1360 fs/nfs/nfs42xdr.c=
:1341)
> [  144.702452] nfs4_xdr_dec_read_plus from call_decode (net/sunrpc/clnt.c=
:2595)
> [  144.708429] call_decode from __rpc_execute (include/asm-generic/bitops=
/generic-non-atomic.h:128 net/sunrpc/sched.c:954)
> [  144.713538] __rpc_execute from rpc_async_schedule (include/linux/sched=
/mm.h:336 net/sunrpc/sched.c:1035)
> [  144.719170] rpc_async_schedule from process_one_work (include/linux/ju=
mp_label.h:260 include/linux/jump_label.h:270 include/trace/events/workqueu=
e.h:108 kernel/workqueue.c:2294)
> [  144.725238] process_one_work from worker_thread (include/linux/list.h:=
292 kernel/workqueue.c:2437)
> [  144.730782] worker_thread from kthread (kernel/kthread.c:378)
> [  144.735547] kthread from ret_from_fork (arch/arm/kernel/entry-common.S=
:149)
>
>
>
> Best regards,
> Krzysztof
>

--000000000000e3cadb05f63e5cc4
Content-Type: text/x-patch; charset="US-ASCII"; name="aglo-read_plus.patch"
Content-Disposition: attachment; filename="aglo-read_plus.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lex2ufs20>
X-Attachment-Id: f_lex2ufs20

ZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0Mnhkci5jIGIvZnMvbmZzL25mczQyeGRyLmMKaW5kZXgg
ZDgwZWU4OGNhOTk2Li5kZWU1ZWNmMDc4NWEgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9uZnM0Mnhkci5j
CisrKyBiL2ZzL25mcy9uZnM0Mnhkci5jCkBAIC0zNDYsNiArMzQ2LDcgQEAgc3RhdGljIHZvaWQg
ZW5jb2RlX3JlYWRfcGx1cyhzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLAogCQkJICAgICBjb25zdCBz
dHJ1Y3QgbmZzX3BnaW9fYXJncyAqYXJncywKIAkJCSAgICAgc3RydWN0IGNvbXBvdW5kX2hkciAq
aGRyKQogeworCXByaW50aygiQUdMTzogJXMgc2V0dGluZyB1cCBkZWNvZGUgYnVmZmVyIHNpemU9
JWRcbiIsIF9fZnVuY19fLCBkZWNvZGVfcmVhZF9wbHVzX21heHN6KTsKIAllbmNvZGVfb3BfaGRy
KHhkciwgT1BfUkVBRF9QTFVTLCBkZWNvZGVfcmVhZF9wbHVzX21heHN6LCBoZHIpOwogCWVuY29k
ZV9uZnM0X3N0YXRlaWQoeGRyLCAmYXJncy0+c3RhdGVpZCk7CiAJZW5jb2RlX3VpbnQ2NCh4ZHIs
IGFyZ3MtPm9mZnNldCk7CkBAIC0xMDU5LDYgKzEwNjAsNyBAQCBzdGF0aWMgaW50IGRlY29kZV9y
ZWFkX3BsdXNfc2VnbWVudChzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLAogewogCV9fYmUzMiAqcDsK
IAorCXByaW50aygiQUdMTzogJXMgc3RhcnQgc2VnPSVwXG4iLCBfX2Z1bmNfXywgc2VnKTsKIAlw
ID0geGRyX2lubGluZV9kZWNvZGUoeGRyLCA0KTsKIAlpZiAoIXApCiAJCXJldHVybiAtRUlPOwpA
QCAtMTA4Miw2ICsxMDg0LDcgQEAgc3RhdGljIGludCBkZWNvZGVfcmVhZF9wbHVzX3NlZ21lbnQo
c3RydWN0IHhkcl9zdHJlYW0gKnhkciwKIAkJeGRyX2RlY29kZV9oeXBlcihwLCAmc2VnLT5ob2xl
Lmxlbmd0aCk7CiAJfSBlbHNlCiAJCXJldHVybiAtRUlOVkFMOworCXByaW50aygiQUdMTzogJXMg
ZW5kIHNlZz0lcCB4ZHItPm53b3Jkcz0lZFxuIiwgX19mdW5jX18sIHNlZywgeGRyLT5ud29yZHMp
OwogCXJldHVybiAwOwogfQogCkBAIC0xMTI1LDYgKzExMjgsNyBAQCBzdGF0aWMgaW50IGRlY29k
ZV9yZWFkX3BsdXMoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3RydWN0IG5mc19wZ2lvX3JlcyAq
cmVzKQogCWNoYXIgc2NyYXRjaF9idWZbMTZdOwogCV9fYmUzMiAqcDsKIAorCXByaW50aygiQUdM
TzogJXMgU1RBUlRcbiIsIF9fZnVuY19fKTsKIAlzdGF0dXMgPSBkZWNvZGVfb3BfaGRyKHhkciwg
T1BfUkVBRF9QTFVTKTsKIAlpZiAoc3RhdHVzKQogCQlyZXR1cm4gc3RhdHVzOwpAQCAtMTE1OCw2
ICsxMTYyLDcgQEAgc3RhdGljIGludCBkZWNvZGVfcmVhZF9wbHVzKHN0cnVjdCB4ZHJfc3RyZWFt
ICp4ZHIsIHN0cnVjdCBuZnNfcGdpb19yZXMgKnJlcykKIAogb3V0OgogCWtmcmVlKHNlZ3MpOwor
CXByaW50aygiQUdMTzogJXMgRU5EXG4iLCBfX2Z1bmNfXyk7CiAJcmV0dXJuIHN0YXR1czsKIH0K
IApkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9jbG50LmMgYi9uZXQvc3VucnBjL2NsbnQuYwppbmRl
eCAwYjBiOWYxZWVkNDYuLjM0NDllYTgzNmQzMCAxMDA2NDQKLS0tIGEvbmV0L3N1bnJwYy9jbG50
LmMKKysrIGIvbmV0L3N1bnJwYy9jbG50LmMKQEAgLTEzMzcsNiArMTMzNyw3IEBAIHZvaWQgcnBj
X3ByZXBhcmVfcmVwbHlfcGFnZXMoc3RydWN0IHJwY19ycXN0ICpyZXEsIHN0cnVjdCBwYWdlICoq
cGFnZXMsCiB7CiAJaGRyc2l6ZSArPSBSUENfUkVQSERSU0laRSArIHJlcS0+cnFfY3JlZC0+Y3Jf
YXV0aC0+YXVfcmFsaWduOwogCisJcHJpbnRrKCJBR0xPOiAlcyBoZHJzaXplICVkICg8PDIgJWQp
IEhEUlNJWkUgJWQgYXVsaWdoICVkXG4iLCBfX2Z1bmNfXywgaGRyc2l6ZSwgaGRyc2l6ZSA8PCAy
LCBSUENfUkVQSERSU0laRSwgcmVxLT5ycV9jcmVkLT5jcl9hdXRoLT5hdV9yYWxpZ24pOwogCXhk
cl9pbmxpbmVfcGFnZXMoJnJlcS0+cnFfcmN2X2J1ZiwgaGRyc2l6ZSA8PCAyLCBwYWdlcywgYmFz
ZSwgbGVuKTsKIAl0cmFjZV9ycGNfeGRyX3JlcGx5X3BhZ2VzKHJlcS0+cnFfdGFzaywgJnJlcS0+
cnFfcmN2X2J1Zik7CiB9CmRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3hkci5jIGIvbmV0L3N1bnJw
Yy94ZHIuYwppbmRleCBmNzc2N2JmMjI0MDYuLmUxYmI5ZmNiYWFkNiAxMDA2NDQKLS0tIGEvbmV0
L3N1bnJwYy94ZHIuYworKysgYi9uZXQvc3VucnBjL3hkci5jCkBAIC0xMzk3LDYgKzEzOTcsNyBA
QCBzdGF0aWMgX19iZTMyICogX194ZHJfaW5saW5lX2RlY29kZShzdHJ1Y3QgeGRyX3N0cmVhbSAq
eGRyLCBzaXplX3QgbmJ5dGVzKQogCV9fYmUzMiAqcCA9IHhkci0+cDsKIAlfX2JlMzIgKnEgPSBw
ICsgbndvcmRzOwogCisJcHJpbnRrKCJBR0xPOiAlcyBud29yZHM9JWQgeGRyLT5ud29yZHM9JWQg
cT0lcCB4ZHItPmVuZD0lcCBwPSVwICglZCAlZClcbiIsIF9fZnVuY19fLCBud29yZHMsIHhkci0+
bndvcmRzLCBxLCB4ZHItPmVuZCwgcCwgcSA+IHhkci0+ZW5kLCBxIDwgcCk7CiAJaWYgKHVubGlr
ZWx5KG53b3JkcyA+IHhkci0+bndvcmRzIHx8IHEgPiB4ZHItPmVuZCB8fCBxIDwgcCkpCiAJCXJl
dHVybiBOVUxMOwogCXhkci0+cCA9IHE7CkBAIC0xNDEwLDYgKzE0MTEsNyBAQCBzdGF0aWMgX19i
ZTMyICp4ZHJfY29weV90b19zY3JhdGNoKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsIHNpemVfdCBu
Ynl0ZXMpCiAJY2hhciAqY3BkZXN0ID0geGRyLT5zY3JhdGNoLmlvdl9iYXNlOwogCXNpemVfdCBj
cGxlbiA9IChjaGFyICopeGRyLT5lbmQgLSAoY2hhciAqKXhkci0+cDsKIAorCXByaW50aygiQUdM
TzogJXMgaGVyZVxuIiwgX19mdW5jX18pOwogCWlmIChuYnl0ZXMgPiB4ZHItPnNjcmF0Y2guaW92
X2xlbikKIAkJZ290byBvdXRfb3ZlcmZsb3c7CiAJcCA9IF9feGRyX2lubGluZV9kZWNvZGUoeGRy
LCBjcGxlbik7Cg==
--000000000000e3cadb05f63e5cc4--
