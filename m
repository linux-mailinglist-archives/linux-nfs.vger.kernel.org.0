Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFC57D37A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiGUSlT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 14:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUSlT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 14:41:19 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A3D32B92
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 11:41:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c20so1933095qtw.8
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject;
        bh=+m4HI3ifoLTVsxzoe3VtJMXXum2ZrpP4hnL5fhcNW9E=;
        b=Lt35IxxZk4x/8q01iA57+mpN1bdf6hClHBBwbKxBdBloCEZUH6xAqrYAso4MnD5uzq
         fZwfeUeIc6NY9LvM7j+wJHZQazekQ8LqD5CMoFbB8AO9F8+d3H+dg/LvyP7g20F4uWy8
         2f9ZXPcQn4dSbsfUl31YG0ybKpdYwEr3lLAjp0s3qTIkww+BUdeIgAIMGx5R2QxTxYbB
         rVspzSfMRRc/9qWq3Xuz8Oy+O06jyBNcozPtRTN/kph4jz+NAQCOfR9xN9efSNtkSe7f
         /tKijRcX53oJ9p6ro+DEDsJ0xIOG2ay0hJ7HhUX0yduP/ps/0jbCKZtJK0Ift3FQQtm4
         paAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject;
        bh=+m4HI3ifoLTVsxzoe3VtJMXXum2ZrpP4hnL5fhcNW9E=;
        b=CPYDQ7ub5GCLvjts1h6ZqKq2k+o4R2ImqlyZt7gXfX9uCUUuuXxYEMpBobuOodYeG5
         1tna8pnJINzZ4ffq+PaSik8chGwAAlhzB+mZI6PV3nJdgLEfVBKtjFSc2tlvb/JU8TeS
         Uegg32ZppgFVAWEDBLhGwLRJ7Hnd9HfwhAJ4Y5qvVUvXhiaguRkht4xjO/PsJjc2UBaJ
         FhM0pSvywPb9VSpfau+S9zGN1Nf4bI3p07U134g03OA+gKH0k6PtplMsVS34xsTNhA1u
         hywvYcn3X9PNlt76ZXgpQ0BUL6UpoLF0+HWHnAxdSGxpdeW62THxsmqDle1ajaBqmmtE
         sbuQ==
X-Gm-Message-State: AJIora+T8ZT09XDUIxn7jufWcbZ8oj8DgMVA1mvrggwB2vTshDJD1q8D
        bQHTwkFmf1Sgl2CpzMZh/0grDj3b3ZBXzQ==
X-Google-Smtp-Source: AGRyM1uSClTzAP9biecpslUgLuiEzhIpq90iFHoPRr/Yr97ngAvUIfJsSqzPVV4pyff9+L0qEaMBBA==
X-Received: by 2002:ac8:5f52:0:b0:31f:19f:669c with SMTP id y18-20020ac85f52000000b0031f019f669cmr11417767qta.474.1658428876946;
        Thu, 21 Jul 2022 11:41:16 -0700 (PDT)
Received: from [192.168.0.156] (pool-72-70-58-62.bstnma.fios.verizon.net. [72.70.58.62])
        by smtp.gmail.com with ESMTPSA id k14-20020ac85fce000000b0031ed2038c15sm1791484qta.63.2022.07.21.11.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 11:41:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------oFtwW1i0DAjNoH7xyxBYt3Gc"
Message-ID: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
Date:   Thu, 21 Jul 2022 14:41:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
Subject: Thread safe client destruction
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------oFtwW1i0DAjNoH7xyxBYt3Gc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,


I found yet more potential MT flaws in clnt_dg.c and clnt_vg.c.

1. In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to TRUE, 
with no corresponding clearing when the operation (*xdr_res() call) is 
completed. This would leave other waiting operations blocked 
indefinitely, effectively deadlocked. For comparison, clnt_vd_freeres() 
in clnt_vc.c does not set the active state to TRUE. I believe the vc 
behavior is correct, while the dg behavior is a bug.

2. If clnt_dg_destroy() or clnt_vc_destroy() is awoken with other 
blocked operations pending (such as clnt_*_call(), clnt_*_control(), or 
clnt_*_freeres()) but no active operation currently being executed, then 
the client gets destroyed. Then, as the other blocked operations get 
subsequently awoken, they will try operate on an invalid client handle, 
potentially causing unpredictable behavior and stack corruption.

The proposed fix is to introduce a simple mutexed counting variable into 
the client lock structure, which keeps track of the number of pending 
blocking operations on the client. This way, clnt_*_destroy() can check 
if there are any operations pending on a client, and keep waiting until 
all pending operations are completed, before the client is destroyed 
safely and its resources are freed.

Attached is a patch with the above fixes.

-- A.
--------------oFtwW1i0DAjNoH7xyxBYt3Gc
Content-Type: text/x-patch; charset=UTF-8; name="clnt_mt_safe_destroy.patch"
Content-Disposition: attachment; filename="clnt_mt_safe_destroy.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NyYy9jbG50X2RnLmMgYi9zcmMvY2xudF9kZy5jCmluZGV4IGIzZDgy
ZTcuLjlmNzVlN2MgMTAwNjQ0Ci0tLSBhL3NyYy9jbG50X2RnLmMKKysrIGIvc3JjL2NsbnRf
ZGcuYwpAQCAtMTAxLDYgKzEwMSw3IEBAIGV4dGVybiBtdXRleF90IGNsbnRfZmRfbG9jazsK
ICNkZWZpbmUJcmVsZWFzZV9mZF9sb2NrKGZkX2xvY2ssIG1hc2spIHsJXAogCW11dGV4X2xv
Y2soJmNsbnRfZmRfbG9jayk7CVwKIAlmZF9sb2NrLT5hY3RpdmUgPSBGQUxTRTsJXAorCWZk
X2xvY2stPnBlbmRpbmctLTsJCVwKIAltdXRleF91bmxvY2soJmNsbnRfZmRfbG9jayk7CVwK
IAl0aHJfc2lnc2V0bWFzayhTSUdfU0VUTUFTSywgJihtYXNrKSwgTlVMTCk7IFwKIAljb25k
X3NpZ25hbCgmZmRfbG9jay0+Y3YpOwlcCkBAIC0zMDgsNiArMzA5LDcgQEAgY2xudF9kZ19j
YWxsKGNsLCBwcm9jLCB4YXJncywgYXJnc3AsIHhyZXN1bHRzLCByZXN1bHRzcCwgdXRpbWVv
dXQpCiAJc2lnZmlsbHNldCgmbmV3bWFzayk7CiAJdGhyX3NpZ3NldG1hc2soU0lHX1NFVE1B
U0ssICZuZXdtYXNrLCAmbWFzayk7CiAJbXV0ZXhfbG9jaygmY2xudF9mZF9sb2NrKTsKKwlj
dS0+Y3VfZmRfbG9jay0+cGVuZGluZysrOwogCXdoaWxlIChjdS0+Y3VfZmRfbG9jay0+YWN0
aXZlKQogCQljb25kX3dhaXQoJmN1LT5jdV9mZF9sb2NrLT5jdiwgJmNsbnRfZmRfbG9jayk7
CiAJY3UtPmN1X2ZkX2xvY2stPmFjdGl2ZSA9IFRSVUU7CkBAIC01NjgsMTEgKzU3MCwxMiBA
QCBjbG50X2RnX2ZyZWVyZXMoY2wsIHhkcl9yZXMsIHJlc19wdHIpCiAJc2lnZmlsbHNldCgm
bmV3bWFzayk7CiAJdGhyX3NpZ3NldG1hc2soU0lHX1NFVE1BU0ssICZuZXdtYXNrLCAmbWFz
ayk7CiAJbXV0ZXhfbG9jaygmY2xudF9mZF9sb2NrKTsKKwljdS0+Y3VfZmRfbG9jay0+cGVu
ZGluZysrOwogCXdoaWxlIChjdS0+Y3VfZmRfbG9jay0+YWN0aXZlKQogCQljb25kX3dhaXQo
JmN1LT5jdV9mZF9sb2NrLT5jdiwgJmNsbnRfZmRfbG9jayk7Ci0JY3UtPmN1X2ZkX2xvY2st
PmFjdGl2ZSA9IFRSVUU7CiAJeGRycy0+eF9vcCA9IFhEUl9GUkVFOwogCWR1bW15ID0gKCp4
ZHJfcmVzKSh4ZHJzLCByZXNfcHRyKTsKKwljdS0+Y3VfZmRfbG9jay0+cGVuZGluZy0tOwog
CW11dGV4X3VubG9jaygmY2xudF9mZF9sb2NrKTsKIAl0aHJfc2lnc2V0bWFzayhTSUdfU0VU
TUFTSywgJm1hc2ssIE5VTEwpOwogCWNvbmRfc2lnbmFsKCZjdS0+Y3VfZmRfbG9jay0+Y3Yp
OwpAQCAtNjAwLDYgKzYwMyw3IEBAIGNsbnRfZGdfY29udHJvbChjbCwgcmVxdWVzdCwgaW5m
bykKIAlzaWdmaWxsc2V0KCZuZXdtYXNrKTsKIAl0aHJfc2lnc2V0bWFzayhTSUdfU0VUTUFT
SywgJm5ld21hc2ssICZtYXNrKTsKIAltdXRleF9sb2NrKCZjbG50X2ZkX2xvY2spOworCWN1
LT5jdV9mZF9sb2NrLT5wZW5kaW5nKys7CiAJd2hpbGUgKGN1LT5jdV9mZF9sb2NrLT5hY3Rp
dmUpCiAJCWNvbmRfd2FpdCgmY3UtPmN1X2ZkX2xvY2stPmN2LCAmY2xudF9mZF9sb2NrKTsK
IAljdS0+Y3VfZmRfbG9jay0+YWN0aXZlID0gVFJVRTsKQEAgLTc0MCw3ICs3NDQsNyBAQCBj
bG50X2RnX2Rlc3Ryb3koY2wpCiAJc2lnZmlsbHNldCgmbmV3bWFzayk7CiAJdGhyX3NpZ3Nl
dG1hc2soU0lHX1NFVE1BU0ssICZuZXdtYXNrLCAmbWFzayk7CiAJbXV0ZXhfbG9jaygmY2xu
dF9mZF9sb2NrKTsKLQl3aGlsZSAoY3VfZmRfbG9jay0+YWN0aXZlKQorCXdoaWxlIChjdV9m
ZF9sb2NrLT5hY3RpdmUgfHwgY3VfZmRfbG9jay0+cGVuZGluZyA+IDApCiAJCWNvbmRfd2Fp
dCgmY3VfZmRfbG9jay0+Y3YsICZjbG50X2ZkX2xvY2spOwogCWlmIChjdS0+Y3VfY2xvc2Vp
dCkKIAkJKHZvaWQpY2xvc2UoY3VfZmQpOwpkaWZmIC0tZ2l0IGEvc3JjL2NsbnRfZmRfbG9j
a3MuaCBiL3NyYy9jbG50X2ZkX2xvY2tzLmgKaW5kZXggMzU5Zjk5NS4uNmJhNjJjYiAxMDA2
NDQKLS0tIGEvc3JjL2NsbnRfZmRfbG9ja3MuaAorKysgYi9zcmMvY2xudF9mZF9sb2Nrcy5o
CkBAIC01MCw2ICs1MCw3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgZmRfbG9ja3NfcHJlYWxs
b2MgPSAwOwogLyogcGVyLWZkIGxvY2sgKi8KIHN0cnVjdCBmZF9sb2NrX3QgewogCWJvb2xf
dCBhY3RpdmU7CisJaW50IHBlbmRpbmc7ICAgICAgICAvKiBOdW1iZXIgb2YgcGVuZGluZyBv
cGVyYXRpb25zIG9uIGZkICovCiAJY29uZF90IGN2OwogfTsKIHR5cGVkZWYgc3RydWN0IGZk
X2xvY2tfdCBmZF9sb2NrX3Q7CkBAIC0xODAsNiArMTgxLDcgQEAgZmRfbG9ja190KiBmZF9s
b2NrX2NyZWF0ZShpbnQgZmQsIGZkX2xvY2tzX3QgKmZkX2xvY2tzKSB7CiAJCWl0ZW0tPmZk
ID0gZmQ7CiAJCWl0ZW0tPnJlZnMgPSAxOwogCQlpdGVtLT5mZF9sb2NrLmFjdGl2ZSA9IEZB
TFNFOworCQlpdGVtLT5mZF9sb2NrLnBlbmRpbmcgPSAwOwogCQljb25kX2luaXQoJml0ZW0t
PmZkX2xvY2suY3YsIDAsICh2b2lkICopIDApOwogCQlUQUlMUV9JTlNFUlRfSEVBRChsaXN0
LCBpdGVtLCBsaW5rKTsKIAl9IGVsc2UgewpkaWZmIC0tZ2l0IGEvc3JjL2NsbnRfdmMuYyBi
L3NyYy9jbG50X3ZjLmMKaW5kZXggYTA3ZTI5Ny4uOGY5Y2E3NCAxMDA2NDQKLS0tIGEvc3Jj
L2NsbnRfdmMuYworKysgYi9zcmMvY2xudF92Yy5jCkBAIC0xNTMsNiArMTUzLDcgQEAgZXh0
ZXJuIG11dGV4X3QgIGNsbnRfZmRfbG9jazsKICNkZWZpbmUgcmVsZWFzZV9mZF9sb2NrKGZk
X2xvY2ssIG1hc2spIHsJXAogCW11dGV4X2xvY2soJmNsbnRfZmRfbG9jayk7CVwKIAlmZF9s
b2NrLT5hY3RpdmUgPSBGQUxTRTsJXAorCWZkX2xvY2stPnBlbmRpbmctLTsJCVwKIAltdXRl
eF91bmxvY2soJmNsbnRfZmRfbG9jayk7CVwKIAl0aHJfc2lnc2V0bWFzayhTSUdfU0VUTUFT
SywgJihtYXNrKSwgKHNpZ3NldF90ICopIE5VTEwpOwlcCiAJY29uZF9zaWduYWwoJmZkX2xv
Y2stPmN2KTsJXApAQCAtMzUzLDYgKzM1NCw3IEBAIGNsbnRfdmNfY2FsbChjbCwgcHJvYywg
eGRyX2FyZ3MsIGFyZ3NfcHRyLCB4ZHJfcmVzdWx0cywgcmVzdWx0c19wdHIsIHRpbWVvdXQp
CiAJc2lnZmlsbHNldCgmbmV3bWFzayk7CiAJdGhyX3NpZ3NldG1hc2soU0lHX1NFVE1BU0ss
ICZuZXdtYXNrLCAmbWFzayk7CiAJbXV0ZXhfbG9jaygmY2xudF9mZF9sb2NrKTsKKwljdC0+
Y3RfZmRfbG9jay0+cGVuZGluZysrOwogCXdoaWxlIChjdC0+Y3RfZmRfbG9jay0+YWN0aXZl
KQogCQljb25kX3dhaXQoJmN0LT5jdF9mZF9sb2NrLT5jdiwgJmNsbnRfZmRfbG9jayk7CiAJ
Y3QtPmN0X2ZkX2xvY2stPmFjdGl2ZSA9IFRSVUU7CkBAIC00OTEsMTAgKzQ5MywxMiBAQCBj
bG50X3ZjX2ZyZWVyZXMoY2wsIHhkcl9yZXMsIHJlc19wdHIpCiAJc2lnZmlsbHNldCgmbmV3
bWFzayk7CiAJdGhyX3NpZ3NldG1hc2soU0lHX1NFVE1BU0ssICZuZXdtYXNrLCAmbWFzayk7
CiAJbXV0ZXhfbG9jaygmY2xudF9mZF9sb2NrKTsKKwljdC0+Y3RfZmRfbG9jay0+cGVuZGlu
ZysrOwogCXdoaWxlIChjdC0+Y3RfZmRfbG9jay0+YWN0aXZlKQogCQljb25kX3dhaXQoJmN0
LT5jdF9mZF9sb2NrLT5jdiwgJmNsbnRfZmRfbG9jayk7CiAJeGRycy0+eF9vcCA9IFhEUl9G
UkVFOwogCWR1bW15ID0gKCp4ZHJfcmVzKSh4ZHJzLCByZXNfcHRyKTsKKwljdC0+Y3RfZmRf
bG9jay0+cGVuZGluZy0tOwogCW11dGV4X3VubG9jaygmY2xudF9mZF9sb2NrKTsKIAl0aHJf
c2lnc2V0bWFzayhTSUdfU0VUTUFTSywgJihtYXNrKSwgTlVMTCk7CiAJY29uZF9zaWduYWwo
JmN0LT5jdF9mZF9sb2NrLT5jdik7CkBAIC01MjksNiArNTMzLDcgQEAgY2xudF92Y19jb250
cm9sKGNsLCByZXF1ZXN0LCBpbmZvKQogCXNpZ2ZpbGxzZXQoJm5ld21hc2spOwogCXRocl9z
aWdzZXRtYXNrKFNJR19TRVRNQVNLLCAmbmV3bWFzaywgJm1hc2spOwogCW11dGV4X2xvY2so
JmNsbnRfZmRfbG9jayk7CisJY3QtPmN0X2ZkX2xvY2stPnBlbmRpbmcrKzsKIAl3aGlsZSAo
Y3QtPmN0X2ZkX2xvY2stPmFjdGl2ZSkKIAkJY29uZF93YWl0KCZjdC0+Y3RfZmRfbG9jay0+
Y3YsICZjbG50X2ZkX2xvY2spOwogCWN0LT5jdF9mZF9sb2NrLT5hY3RpdmUgPSBUUlVFOwpA
QCAtNjUxLDcgKzY1Niw3IEBAIGNsbnRfdmNfZGVzdHJveShjbCkKIAlzaWdmaWxsc2V0KCZu
ZXdtYXNrKTsKIAl0aHJfc2lnc2V0bWFzayhTSUdfU0VUTUFTSywgJm5ld21hc2ssICZtYXNr
KTsKIAltdXRleF9sb2NrKCZjbG50X2ZkX2xvY2spOwotCXdoaWxlIChjdF9mZF9sb2NrLT5h
Y3RpdmUpCisJd2hpbGUgKGN0X2ZkX2xvY2stPmFjdGl2ZSB8fCBjdF9mZF9sb2NrLT5wZW5k
aW5nID4gMCkKIAkJY29uZF93YWl0KCZjdF9mZF9sb2NrLT5jdiwgJmNsbnRfZmRfbG9jayk7
CiAJaWYgKGN0LT5jdF9jbG9zZWl0ICYmIGN0LT5jdF9mZCAhPSAtMSkgewogCQkodm9pZClj
bG9zZShjdC0+Y3RfZmQpOwo=

--------------oFtwW1i0DAjNoH7xyxBYt3Gc--
