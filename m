Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02AF6937AC
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Feb 2023 15:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBLOGL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Feb 2023 09:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBLOGK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Feb 2023 09:06:10 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D93C11EB5;
        Sun, 12 Feb 2023 06:06:06 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id p16so3858534qki.9;
        Sun, 12 Feb 2023 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WLsmoPCaetnyKB5wRMApvAff4Jx1/sqybqlgrpDwf8Y=;
        b=ZK5LzAhsUJ1tjNk3z7lHAsEo+Z5samSodYbkay5tuZKgC6m9ygJVBJXgWznsEUstlR
         Sa/yWpeBMt1e33k8Q1gHOXHkge1qm0kXiGKDIn99cFP6/8FeR0KH/zE1uyEmvNKvpTG9
         qKtvPo6dPepgQ9adkoTmQ7m3V/Dph5IoByOOjdptnf0228qwB5z1Gbqcs1JWv9gHFrGY
         oHVOIYPcHiiYVt/AKrOs6lofbpx+Uo3YD40rz2Sna+mDEdxjRKtbxT8vtMMUCXsamnFU
         1+3uirWnfFlpNzwh+NSOlV4Kh4R2+6sbkpc6ucsU26PbDWukxSIyeQCF8A+FXLJrsniJ
         i9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLsmoPCaetnyKB5wRMApvAff4Jx1/sqybqlgrpDwf8Y=;
        b=k5NoI8NghZ4fNCHGlPTlslJ0DRaEAJUJJbRERnYgdGGW7SiQ0iA6i5JpvjKFF9puTJ
         JTRXkKB4XxJPxFIS+0rHcR/zhehBYkg5Mc0ZLO+FVb79d+ZAwYBP5b6uIAKalSEZO80s
         QJ2RuuQNYqJY895CM2Euu9o0MhwcFAsIvIhYzbxpFH8B3lBXqtF3uKeGOhiZxJyaAZu7
         MGdNnsPsh1J9YbWV97Lh9kW4YiPVE/uDkInAcr0UmuiQUl58YwnF/sYKsNg8tdF2V3zg
         N0nz8CR8Xd3yUBbkTdhsaqOGYnP/IH8F7mo+CKXqg+6BX5Vd8/N60ENEj7j/OMLZDxJT
         0zhA==
X-Gm-Message-State: AO0yUKXfXuUVH6solgxGuLOcZWo25xncc8Vd1RzlUS3p/zhX0Gy5AMgi
        6qH5bf/CbTAA1XvPn0Od2AoRNnfaTaKUE0+maDTXkdEm
X-Google-Smtp-Source: AK7set+3ZP1jCqlBEC0WpqasMK9RYzHfWAOiyO9nm22lCTXqTpK15C7r/IpCKnFaz34OYd3W0Hj1KhRTI9uqzWEDVRQ=
X-Received: by 2002:a37:680b:0:b0:739:1900:6eb3 with SMTP id
 d11-20020a37680b000000b0073919006eb3mr260793qkc.477.1676210765073; Sun, 12
 Feb 2023 06:06:05 -0800 (PST)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org> <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org> <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
 <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org> <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
 <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org> <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com> <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org>
In-Reply-To: <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Sun, 12 Feb 2023 09:05:48 -0500
Message-ID: <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="00000000000038d58905f4813b7a"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--00000000000038d58905f4813b7a
Content-Type: text/plain; charset="UTF-8"

On Sat, Feb 11, 2023 at 6:23 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 21:55, Anna Schumaker wrote:
> > Hi Krzysztof,
> >
> > On Fri, Feb 10, 2023 at 3:53 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 10/02/2023 09:41, Krzysztof Kozlowski wrote:
> >>>
> >>>
> >>>>
> >>>> I was also wondering if it would be possible to turn on KASAN in your
> >>>> kernel, which should give us a little more info?
> >>>
> >>> I'll try with KASAN.
> >>
> >> Not much from the KASAN, except that kernel
> >> continues to boot and runs:
> >>
> >> [   44.722846] vdd_vmem: disabling
> >> [   44.793465] systemd[1]: Hostname set to <odroidhc1>.
> >> [   45.357929] systemd[1]: bpf-lsm: BPF LSM hook not enabled in the kernel, BPF LSM not supported
> >> [   45.980476] ==================================================================
> >> [   45.986372] BUG: KASAN: null-ptr-deref in xdr_inline_decode+0x140/0x200
> >> [   45.992929] Read of size 4092 at addr 00000004 by task kworker/u16:3/71
> >> [   45.999513]
> >> [   46.000940] CPU: 6 PID: 71 Comm: kworker/u16:3 Not tainted 6.2.0-rc7-00018-g0983f6bf2bfc #222
> >> [   46.009504] Hardware name: Samsung Exynos (Flattened Device Tree)
> >> [   46.015542] Workqueue: rpciod rpc_async_schedule
> >> [   46.020123]  unwind_backtrace from show_stack+0x10/0x14
> >> [   46.025323]  show_stack from dump_stack_lvl+0x58/0x70
> >> [   46.030301]  dump_stack_lvl from kasan_report+0xa8/0xe0
> >> [   46.035501]  kasan_report from kasan_check_range+0x94/0x1a0
> >> [   46.041048]  kasan_check_range from memcpy+0x28/0x68
> >> [   46.045985]  memcpy from xdr_inline_decode+0x140/0x200
> >> [   46.051098]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x298/0x5b8
> >> [   46.057602]  nfs4_xdr_dec_read_plus from call_decode+0x39c/0x530
> >> [   46.063581]  call_decode from __rpc_execute+0x1f4/0xc5c
> >> [   46.068776]  __rpc_execute from rpc_async_schedule+0x2c/0x4c
> >> [   46.074411]  rpc_async_schedule from process_one_work+0x51c/0xc44
> >> [   46.080478]  process_one_work from worker_thread+0x9c/0x7c0
> >> [   46.086022]  worker_thread from kthread+0x16c/0x1b8
> >> [   46.090872]  kthread from ret_from_fork+0x14/0x2c
> >> [   46.095550] Exception stack(0xf0ba3fb0 to 0xf0ba3ff8)
> >> [   46.100580] 3fa0:                                     00000000 00000000 00000000 00000000
> >> [   46.108740] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> >> [   46.116885] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >> [   46.123461] ==================================================================
> >> [   46.130774] Disabling lock debugging due to kernel taint
> >> [   50.848579] systemd[1]: Queued start job for default target Graphical Interface.
> >> [   50.877068] systemd[1]: Created slice Slice /system/getty.
> >>
> >>
> >> Decoded stacktrace is (this is master branch):
> >>
> >> [   46.020123] unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
> >> [   46.025323] show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
> >> [   46.030301] dump_stack_lvl from kasan_report (mm/kasan/report.c:184 mm/kasan/report.c:519)
> >> [   46.035501] kasan_report from kasan_check_range (mm/kasan/generic.c:173 mm/kasan/generic.c:189)
> >> [   46.041048] kasan_check_range from memcpy (mm/kasan/shadow.c:65)
> >> [   46.045985] memcpy from xdr_inline_decode (net/sunrpc/xdr.c:1419 net/sunrpc/xdr.c:1454)
> >
> > Actually, this part is really useful. net/sunrpc/xdr.c:1419 points to
> > the memcpy in xdr_copy_to_scratch(), which has me wondering if I'm
> > incorrectly setting up the xdr scratch buffer that READ_PLUS uses for
> > decoding. Can you try this patch and let me know if it helps?
> >
> > From ac2d6c501dbcdb306480edaee625b5496f1fb4f5 Mon Sep 17 00:00:00 2001
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > Date: Fri, 10 Feb 2023 15:50:22 -0500
> > Subject: [PATCH] NFSv4.2: Rework scratch handling for READ_PLUS
> >
>
> Patch is corrupted - maybe mail program reformatted it when sending:
>
> Applying: NFSv4.2: Rework scratch handling for READ_PLUS
> error: corrupt patch at line 12
> Patch failed at 0001 NFSv4.2: Rework scratch handling for READ_PLUS

That's weird. I wasn't expecting gmail to reformat the patch but I
guess it did. I've added it as an attachment so that shouldn't happen
again.

Sorry about that!
Anna

>
>
> Best regards,
> Krzysztof
>

--00000000000038d58905f4813b7a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-NFSv4.2-Rework-scratch-handling-for-READ_PLUS.patch"
Content-Disposition: attachment; 
	filename="0001-NFSv4.2-Rework-scratch-handling-for-READ_PLUS.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_le1glenh0>
X-Attachment-Id: f_le1glenh0

RnJvbSBhYzJkNmM1MDFkYmNkYjMwNjQ4MGVkYWVlNjI1YjU0OTZmMWZiNGY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogRnJpLCAxMCBGZWIgMjAyMyAxNTo1MDoyMiAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIE5GU3Y0LjI6IFJld29yayBzY3JhdGNoIGhhbmRsaW5nIGZvciBSRUFEX1BMVVMKCkluc3Rl
YWQgb2YgdXNpbmcgYSB0aW55IHNjcmF0Y2ggYnVmZmVyLCB3ZSBzaG91bGQgdXNlIGEgZnVsbCBz
Y3JhdGNoCnBhZ2UgdG8gbWF0Y2ggaG93IG90aGVyIE5GU3Y0IG9wZXJhdGlvbnMgaGFuZGxlIHNj
cmF0Y2ggZGF0YS4KClNpZ25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtl
ckBOZXRhcHAuY29tPgotLS0KIGZzL25mcy9uZnM0Mnhkci5jICAgICAgIHwgIDQgKystLQogZnMv
bmZzL25mczRwcm9jLmMgICAgICAgfCAxNCArKysrKysrKysrLS0tLQogaW5jbHVkZS9saW51eC9u
ZnNfeGRyLmggfCAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczQyeGRyLmMgYi9mcy9uZnMvbmZzNDJ4
ZHIuYwppbmRleCBkODBlZTg4Y2E5OTYuLjcwMjU2N2Q1YjFkYiAxMDA2NDQKLS0tIGEvZnMvbmZz
L25mczQyeGRyLmMKKysrIGIvZnMvbmZzL25mczQyeGRyLmMKQEAgLTExMjIsNyArMTEyMiw2IEBA
IHN0YXRpYyBpbnQgZGVjb2RlX3JlYWRfcGx1cyhzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCBzdHJ1
Y3QgbmZzX3BnaW9fcmVzICpyZXMpCiAJdWludDMyX3Qgc2VnbWVudHM7CiAJc3RydWN0IHJlYWRf
cGx1c19zZWdtZW50ICpzZWdzOwogCWludCBzdGF0dXMsIGk7Ci0JY2hhciBzY3JhdGNoX2J1Zlsx
Nl07CiAJX19iZTMyICpwOwogCiAJc3RhdHVzID0gZGVjb2RlX29wX2hkcih4ZHIsIE9QX1JFQURf
UExVUyk7CkBAIC0xMTQzLDcgKzExNDIsNiBAQCBzdGF0aWMgaW50IGRlY29kZV9yZWFkX3BsdXMo
c3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3RydWN0IG5mc19wZ2lvX3JlcyAqcmVzKQogCWlmICgh
c2VncykKIAkJcmV0dXJuIC1FTk9NRU07CiAKLQl4ZHJfc2V0X3NjcmF0Y2hfYnVmZmVyKHhkciwg
JnNjcmF0Y2hfYnVmLCBzaXplb2Yoc2NyYXRjaF9idWYpKTsKIAlzdGF0dXMgPSAtRUlPOwogCWZv
ciAoaSA9IDA7IGkgPCBzZWdtZW50czsgaSsrKSB7CiAJCXN0YXR1cyA9IGRlY29kZV9yZWFkX3Bs
dXNfc2VnbWVudCh4ZHIsICZzZWdzW2ldKTsKQEAgLTEzNDgsNiArMTM0Niw4IEBAIHN0YXRpYyBp
bnQgbmZzNF94ZHJfZGVjX3JlYWRfcGx1cyhzdHJ1Y3QgcnBjX3Jxc3QgKnJxc3RwLAogCXN0cnVj
dCBjb21wb3VuZF9oZHIgaGRyOwogCWludCBzdGF0dXM7CiAKKwl4ZHJfc2V0X3NjcmF0Y2hfcGFn
ZSh4ZHIsIHJlcy0+c2NyYXRjaCk7CisKIAlzdGF0dXMgPSBkZWNvZGVfY29tcG91bmRfaGRyKHhk
ciwgJmhkcik7CiAJaWYgKHN0YXR1cykKIAkJZ290byBvdXQ7CmRpZmYgLS1naXQgYS9mcy9uZnMv
bmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jCmluZGV4IDQwZDc0OWYyOWVkMy4uNWM1ODlk
MGJkOWU5IDEwMDY0NAotLS0gYS9mcy9uZnMvbmZzNHByb2MuYworKysgYi9mcy9uZnMvbmZzNHBy
b2MuYwpAQCAtNTQ0MCw2ICs1NDQwLDggQEAgc3RhdGljIGJvb2wgbmZzNF9yZWFkX3BsdXNfbm90
X3N1cHBvcnRlZChzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2ssCiAKIHN0YXRpYyBpbnQgbmZzNF9yZWFk
X2RvbmUoc3RydWN0IHJwY190YXNrICp0YXNrLCBzdHJ1Y3QgbmZzX3BnaW9faGVhZGVyICpoZHIp
CiB7CisJaWYgKGhkci0+cmVzLnNjcmF0Y2gpCisJCV9fZnJlZV9wYWdlKGhkci0+cmVzLnNjcmF0
Y2gpOwogCWlmICghbmZzNF9zZXF1ZW5jZV9kb25lKHRhc2ssICZoZHItPnJlcy5zZXFfcmVzKSkK
IAkJcmV0dXJuIC1FQUdBSU47CiAJaWYgKG5mczRfcmVhZF9zdGF0ZWlkX2NoYW5nZWQodGFzaywg
Jmhkci0+YXJncykpCkBAIC01NDUzLDEyICs1NDU1LDE2IEBAIHN0YXRpYyBpbnQgbmZzNF9yZWFk
X2RvbmUoc3RydWN0IHJwY190YXNrICp0YXNrLCBzdHJ1Y3QgbmZzX3BnaW9faGVhZGVyICpoZHIp
CiB9CiAKICNpZiBkZWZpbmVkIENPTkZJR19ORlNfVjRfMiAmJiBkZWZpbmVkIENPTkZJR19ORlNf
VjRfMl9SRUFEX1BMVVMKLXN0YXRpYyB2b2lkIG5mczQyX3JlYWRfcGx1c19zdXBwb3J0KHN0cnVj
dCBuZnNfcGdpb19oZWFkZXIgKmhkciwKK3N0YXRpYyBib29sIG5mczQyX3JlYWRfcGx1c19zdXBw
b3J0KHN0cnVjdCBuZnNfcGdpb19oZWFkZXIgKmhkciwKIAkJCQkgICAgc3RydWN0IHJwY19tZXNz
YWdlICptc2cpCiB7CiAJLyogTm90ZTogV2UgZG9uJ3QgdXNlIFJFQURfUExVUyB3aXRoIHBORlMg
eWV0ICovCi0JaWYgKG5mc19zZXJ2ZXJfY2FwYWJsZShoZHItPmlub2RlLCBORlNfQ0FQX1JFQURf
UExVUykgJiYgIWhkci0+ZHNfY2xwKQorCWlmIChuZnNfc2VydmVyX2NhcGFibGUoaGRyLT5pbm9k
ZSwgTkZTX0NBUF9SRUFEX1BMVVMpICYmICFoZHItPmRzX2NscCkgewogCQltc2ctPnJwY19wcm9j
ID0gJm5mczRfcHJvY2VkdXJlc1tORlNQUk9DNF9DTE5UX1JFQURfUExVU107CisJCWhkci0+cmVz
LnNjcmF0Y2ggPSBhbGxvY19wYWdlKEdGUF9LRVJORUwpOworCQlyZXR1cm4gaGRyLT5yZXMuc2Ny
YXRjaCAhPSBOVUxMOworCX0KKwlyZXR1cm4gZmFsc2U7CiB9CiAjZWxzZQogc3RhdGljIHZvaWQg
bmZzNDJfcmVhZF9wbHVzX3N1cHBvcnQoc3RydWN0IG5mc19wZ2lvX2hlYWRlciAqaGRyLApAQCAt
NTQ3Myw4ICs1NDc5LDggQEAgc3RhdGljIHZvaWQgbmZzNF9wcm9jX3JlYWRfc2V0dXAoc3RydWN0
IG5mc19wZ2lvX2hlYWRlciAqaGRyLAogCWhkci0+dGltZXN0YW1wICAgPSBqaWZmaWVzOwogCWlm
ICghaGRyLT5wZ2lvX2RvbmVfY2IpCiAJCWhkci0+cGdpb19kb25lX2NiID0gbmZzNF9yZWFkX2Rv
bmVfY2I7Ci0JbXNnLT5ycGNfcHJvYyA9ICZuZnM0X3Byb2NlZHVyZXNbTkZTUFJPQzRfQ0xOVF9S
RUFEXTsKLQluZnM0Ml9yZWFkX3BsdXNfc3VwcG9ydChoZHIsIG1zZyk7CisJaWYgKCFuZnM0Ml9y
ZWFkX3BsdXNfc3VwcG9ydChoZHIsIG1zZykpCisJCW1zZy0+cnBjX3Byb2MgPSAmbmZzNF9wcm9j
ZWR1cmVzW05GU1BST0M0X0NMTlRfUkVBRF07CiAJbmZzNF9pbml0X3NlcXVlbmNlKCZoZHItPmFy
Z3Muc2VxX2FyZ3MsICZoZHItPnJlcy5zZXFfcmVzLCAwLCAwKTsKIH0KIApkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9uZnNfeGRyLmggYi9pbmNsdWRlL2xpbnV4L25mc194ZHIuaAppbmRleCBl
ODZjZjY2NDJkMjEuLjZkODIxYWFmMGIxYSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9uZnNf
eGRyLmgKKysrIGIvaW5jbHVkZS9saW51eC9uZnNfeGRyLmgKQEAgLTY3MCw2ICs2NzAsNyBAQCBz
dHJ1Y3QgbmZzX3BnaW9fcmVzIHsKIAkJc3RydWN0IHsKIAkJCXVuc2lnbmVkIGludAkJcmVwbGVu
OwkJLyogdXNlZCBieSByZWFkICovCiAJCQlpbnQJCQllb2Y7CQkvKiB1c2VkIGJ5IHJlYWQgKi8K
KwkJCXN0cnVjdCBwYWdlCQkqc2NyYXRjaDsJLyogdXNlZCBieSByZWFkICovCiAJCX07CiAJCXN0
cnVjdCB7CiAJCQlzdHJ1Y3QgbmZzX3dyaXRldmVyZiAqCXZlcmY7CQkvKiB1c2VkIGJ5IHdyaXRl
ICovCi0tIAoyLjM5LjEKCg==
--00000000000038d58905f4813b7a--
