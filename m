Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4D157BE52
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jul 2022 21:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGTTUs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jul 2022 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGTTUr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jul 2022 15:20:47 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F2313F2A
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 12:20:46 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a9so14076874qtw.10
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:cc:in-reply-to;
        bh=gVS9zxwV9binEZt7aKyyxTVIW7LDL2V/HUzhngKrzMk=;
        b=KdpPEXEKHXH19dGQKkAUJZjhKKzZYUqtdROhv2nkc81Yb9+EpXlQEUocoSjDCtIlM0
         lbNjBtlWAyHUPm6XCOchYSgpjglVxKS3w8fGiOUOGZGjSB0rn0w4WexQitHSDcK8sWdA
         +vCc3t3/bzypvznUYKdKsCgEroryYJXEJ7LGIIiNcWbB1festbN+7QRP2tqKFzAvv4dE
         iWSeBy6zrOODOvlm4CYotYrj26umIRdC3BqB36WqNFMxNgvKlMA1fanIQe3sMtQCqn4w
         SlWEe1B8Jy43hCQO82/9PIjvKw0+7L3OE4/NjzMZGeYMOLvcEL3Rgoz+ajNEnpbnWT6z
         S/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:cc:in-reply-to;
        bh=gVS9zxwV9binEZt7aKyyxTVIW7LDL2V/HUzhngKrzMk=;
        b=We+361KBgw78T3bF2afZhUeQF228aYnQansxbcf0nLxZdWqveu1hDe9ZCCg5myC5G2
         kIcZ9ivAAl1BjYQ5lREPVpEJng6ka/wVz5HEVLNxm4Kf84LdTjZoF8185b9K+X3jD76W
         kd0h9TOKjEQ+Ro6dKpTIC8+tIhkoTQ7Vc1rMFBaN3j9SuOnp4jydhWoex5+UUlD0PWd6
         ihoCrY3iPGvF9h1w5rRMru/hXqf/ZMSc8TVH7TIcfv8yHzUHHNeVT9Wqw1xmZTeyouR/
         QBnY3bVcf/tuulzOXKxF3YoXThyil2OWtXkj+9JSQvTLyzKLp5a+jHBKLQJKX9ePdrk6
         RjuQ==
X-Gm-Message-State: AJIora9aipcp1ny4A6o77bm8wYBzs8VX2ZJDk8AZO1GPFaQMeKE/UFQh
        PJMSCZOVpHcko4yEAZdHFYIScg==
X-Google-Smtp-Source: AGRyM1sL8XwaKNo6SJAS+kN9lUgthPBCQ5PTZDRv6IcBS6K7KXJwo7SvaA9u5y/b31zT14UTrcrPPw==
X-Received: by 2002:a05:622a:50c:b0:31e:eecb:2afb with SMTP id l12-20020a05622a050c00b0031eeecb2afbmr13359183qtx.183.1658344845147;
        Wed, 20 Jul 2022 12:20:45 -0700 (PDT)
Received: from [131.142.152.103] (dhcp-131-142-152-103.cfa.harvard.edu. [131.142.152.103])
        by smtp.gmail.com with ESMTPSA id bl25-20020a05620a1a9900b006a787380a5csm17299429qkb.67.2022.07.20.12.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 12:20:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------rvdaZ05bnUFFaj27shbwex67"
Message-ID: <ec9a624b-d08d-d623-2e93-705a986f7422@cfa.harvard.edu>
Date:   Wed, 20 Jul 2022 15:20:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: libtirpc deadlocks and race conditions patch
Content-Language: en-US
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
To:     libtirpc-devel@lists.sourceforge.net
References: <76bfebd4-b4cd-4403-8a6d-676705bfdcf9@cfa.harvard.edu>
 <6b6c9e8b-deb1-f570-a082-2924eb1aef98@cfa.harvard.edu>
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <6b6c9e8b-deb1-f570-a082-2924eb1aef98@cfa.harvard.edu>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------rvdaZ05bnUFFaj27shbwex67
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Attached is the patch for the previously mentioned issues of 
clnt_create() deadlocking on errors, and cond_signal() being unprotected 
against asyncronous calls to clnt_destroy().

cheers,

-- A.


On 7/20/22 14:16, Attila Kovacs wrote:
> 
> More mutex issues -- this time more likely to do with the connect 
> deadlock we see:
> 
> in clnt_dg.c, in clnt_dg_create():
> 
> 
> clnt_fd_lock is locked on L171, but then not released if jumping to the 
> err1 label on an error (L175 and L180). This means that those errors 
> will deadlock all further operations that require clnt_fd_lock access.
> 
> Same in clnt_vc.c in clnt_vc_create, on lines 215, 222, and 230 
> respectively.
> 
> -- A.
> 
> 
> 
> 
> 
> On 7/20/22 12:09, Attila Kovacs wrote:
>> Hi Steve,
>>
>>
>> We are using the tirpc library in an MT environment. We are 
>> experiencing occasional deadlocks when calling clnt_create_timed() 
>> concurrently from multiple threads. When this happens, all connect 
>> threads hang, with each thread taking up 100% CPU.
>>
>> I was peeking at the code (release 1.3.2), and some potential problems 
>> I see is how waiting / signaling is implemented on cu->cu_fd_lock.cv 
>> in clnt_dg.c and clnt_vc.c.
>>
>> 1. In cnlt_dg_freeres() and clnt_vc_freeres(), cond_signal() is called 
>> after unlocking the mutex (clnt_fd_lock). The manual of 
>> pthread_cond_signal() allows that, but mentions that for consistent 
>> scheduling, cond_signal() should be called with the waiting mutex 
>> locked.  (i.e. lock -> signal -> unlock, rather than lock -> unlock -> 
>> signal).
>>
>> One of the dangers of signaling with the unlocked mutex, is that in 
>> MT, another thread can lock the mutex before the signal call is made, 
>> and potentially destroy the condition variable (e.g. an asynchronous 
>> call to clnt_*_destroy()). Thus, by the time the signal() is called in 
>> clnt*_freeres(), both the condition may be invalid.
>>
>> The proper sequence here should be:
>>
>>      [...]
>>      mutex_lock(&clnt_fd_lock);
>>      while (ct->ct_fd_lock->active)
>>          cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
>>      xdrs->x_op = XDR_FREE;
>>      dummy = (*xdr_res)(xdrs, res_ptr);
>>      thr_sigsetmask(SIG_SETMASK, &(mask), NULL);
>>      cond_signal(&ct->ct_fd_lock->cv);
>>      mutex_unlock(&clnt_fd_lock);
>>
>>
>> 2. Similar issue in the macro release_fd_lock() in both the vc and dg 
>> sources. Here again the sequence ought to be:
>>
>> #define release_fd_lock(fd_lock, mask) {    \
>>      mutex_lock(&clnt_fd_lock);    \
>>      fd_lock->active = FALSE;    \
>>      thr_sigsetmask(SIG_SETMASK, &(mask), (sigset_t *) NULL); \
>>      cond_signal(&fd_lock->cv);    \
>>      mutex_unlock(&clnt_fd_lock);    \
>> }
>>
>>
>> 3. The use of cond_wait() in clnt_dg.c and clnt_vc.c is also 
>> unprotected against the asynchronous destruction of the condition 
>> variable, since cond_wait() releases the mutex as it enters the 
>> waiting state. So, when it is called again in the while() loop, the 
>> condtion might no longer exist. Thus, before calling cond_wait(), one 
>> should check that the client is valid (not destroyed) inside the wait 
>> loop.
>>
>>
>> I'm not sure if these particular issues are the cause of the deadlocks 
>> we see, but I think they are problematic enough on their own, and 
>> perhaps should be fixed in the next release.
>>
>> Thanks,
>>
>> -- Attila
--------------rvdaZ05bnUFFaj27shbwex67
Content-Type: text/x-patch; charset=UTF-8;
 name="libtirpc-deadlocks-akovacs.patch"
Content-Disposition: attachment; filename="libtirpc-deadlocks-akovacs.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NyYy9jbG50X2RnLmMgYi9zcmMvY2xudF9kZy5jCmluZGV4IGIzZDgy
ZTcuLjdjNWQyMmUgMTAwNjQ0Ci0tLSBhL3NyYy9jbG50X2RnLmMKKysrIGIvc3JjL2NsbnRf
ZGcuYwpAQCAtMTAxLDkgKzEwMSw5IEBAIGV4dGVybiBtdXRleF90IGNsbnRfZmRfbG9jazsK
ICNkZWZpbmUJcmVsZWFzZV9mZF9sb2NrKGZkX2xvY2ssIG1hc2spIHsJXAogCW11dGV4X2xv
Y2soJmNsbnRfZmRfbG9jayk7CVwKIAlmZF9sb2NrLT5hY3RpdmUgPSBGQUxTRTsJXAotCW11
dGV4X3VubG9jaygmY2xudF9mZF9sb2NrKTsJXAogCXRocl9zaWdzZXRtYXNrKFNJR19TRVRN
QVNLLCAmKG1hc2spLCBOVUxMKTsgXAogCWNvbmRfc2lnbmFsKCZmZF9sb2NrLT5jdik7CVwK
KwltdXRleF91bmxvY2soJmNsbnRfZmRfbG9jayk7ICAgIFwKIH0KIAogc3RhdGljIGNvbnN0
IGNoYXIgbWVtX2Vycl9jbG50X2RnW10gPSAiY2xudF9kZ19jcmVhdGU6IG91dCBvZiBtZW1v
cnkiOwpAQCAtMTcyLDEyICsxNzIsMTUgQEAgY2xudF9kZ19jcmVhdGUoZmQsIHN2Y2FkZHIs
IHByb2dyYW0sIHZlcnNpb24sIHNlbmRzeiwgcmVjdnN6KQogCWlmIChkZ19mZF9sb2NrcyA9
PSAoZmRfbG9ja3NfdCAqKSBOVUxMKSB7CiAJCWRnX2ZkX2xvY2tzID0gZmRfbG9ja3NfaW5p
dCgpOwogCQlpZiAoZGdfZmRfbG9ja3MgPT0gKGZkX2xvY2tzX3QgKikgTlVMTCkgeworCQkJ
bXV0ZXhfdW5sb2NrKCZjbG50X2ZkX2xvY2spOwogCQkJZ290byBlcnIxOwogCQl9CiAJfQog
CWZkX2xvY2sgPSBmZF9sb2NrX2NyZWF0ZShmZCwgZGdfZmRfbG9ja3MpOwotCWlmIChmZF9s
b2NrID09IChmZF9sb2NrX3QgKikgTlVMTCkKKwlpZiAoZmRfbG9jayA9PSAoZmRfbG9ja190
ICopIE5VTEwpIHsKKwkJbXV0ZXhfdW5sb2NrKCZjbG50X2ZkX2xvY2spOwogCQlnb3RvIGVy
cjE7CisJfQogCiAJbXV0ZXhfdW5sb2NrKCZjbG50X2ZkX2xvY2spOwogCXRocl9zaWdzZXRt
YXNrKFNJR19TRVRNQVNLLCAmKG1hc2spLCBOVUxMKTsKQEAgLTU3Myw5ICs1NzYsOSBAQCBj
bG50X2RnX2ZyZWVyZXMoY2wsIHhkcl9yZXMsIHJlc19wdHIpCiAJY3UtPmN1X2ZkX2xvY2st
PmFjdGl2ZSA9IFRSVUU7CiAJeGRycy0+eF9vcCA9IFhEUl9GUkVFOwogCWR1bW15ID0gKCp4
ZHJfcmVzKSh4ZHJzLCByZXNfcHRyKTsKLQltdXRleF91bmxvY2soJmNsbnRfZmRfbG9jayk7
CiAJdGhyX3NpZ3NldG1hc2soU0lHX1NFVE1BU0ssICZtYXNrLCBOVUxMKTsKIAljb25kX3Np
Z25hbCgmY3UtPmN1X2ZkX2xvY2stPmN2KTsKKwltdXRleF91bmxvY2soJmNsbnRfZmRfbG9j
ayk7CiAJcmV0dXJuIChkdW1teSk7CiB9CiAKZGlmZiAtLWdpdCBhL3NyYy9jbG50X3ZjLmMg
Yi9zcmMvY2xudF92Yy5jCmluZGV4IGEwN2UyOTcuLjNjNzNlNjUgMTAwNjQ0Ci0tLSBhL3Ny
Yy9jbG50X3ZjLmMKKysrIGIvc3JjL2NsbnRfdmMuYwpAQCAtMTUzLDkgKzE1Myw5IEBAIGV4
dGVybiBtdXRleF90ICBjbG50X2ZkX2xvY2s7CiAjZGVmaW5lIHJlbGVhc2VfZmRfbG9jayhm
ZF9sb2NrLCBtYXNrKSB7CVwKIAltdXRleF9sb2NrKCZjbG50X2ZkX2xvY2spOwlcCiAJZmRf
bG9jay0+YWN0aXZlID0gRkFMU0U7CVwKLQltdXRleF91bmxvY2soJmNsbnRfZmRfbG9jayk7
CVwKIAl0aHJfc2lnc2V0bWFzayhTSUdfU0VUTUFTSywgJihtYXNrKSwgKHNpZ3NldF90ICop
IE5VTEwpOwlcCiAJY29uZF9zaWduYWwoJmZkX2xvY2stPmN2KTsJXAorCW11dGV4X3VubG9j
aygmY2xudF9mZF9sb2NrKTsgICAgXAogfQogCiBzdGF0aWMgY29uc3QgY2hhciBjbG50X3Zj
X2VycnN0cltdID0gIiVzIDogJXMiOwpAQCAtMjE2LDcgKzIxNiw5IEBAIGNsbnRfdmNfY3Jl
YXRlKGZkLCByYWRkciwgcHJvZywgdmVycywgc2VuZHN6LCByZWN2c3opCiAJaWYgKHZjX2Zk
X2xvY2tzID09IChmZF9sb2Nrc190ICopIE5VTEwpIHsKIAkJdmNfZmRfbG9ja3MgPSBmZF9s
b2Nrc19pbml0KCk7CiAJCWlmICh2Y19mZF9sb2NrcyA9PSAoZmRfbG9ja3NfdCAqKSBOVUxM
KSB7Ci0JCQlzdHJ1Y3QgcnBjX2NyZWF0ZWVyciAqY2UgPSAmZ2V0X3JwY19jcmVhdGVlcnIo
KTsKKwkJCXN0cnVjdCBycGNfY3JlYXRlZXJyICpjZTsKKwkJCW11dGV4X3VubG9jaygmY2xu
dF9mZF9sb2NrKTsKKwkJCWNlID0gJmdldF9ycGNfY3JlYXRlZXJyKCk7CiAJCQljZS0+Y2Zf
c3RhdCA9IFJQQ19TWVNURU1FUlJPUjsKIAkJCWNlLT5jZl9lcnJvci5yZV9lcnJubyA9IGVy
cm5vOwogCQkJZ290byBlcnI7CkBAIC0yMjQsNyArMjI2LDkgQEAgY2xudF92Y19jcmVhdGUo
ZmQsIHJhZGRyLCBwcm9nLCB2ZXJzLCBzZW5kc3osIHJlY3ZzeikKIAl9CiAJZmRfbG9jayA9
IGZkX2xvY2tfY3JlYXRlKGZkLCB2Y19mZF9sb2Nrcyk7CiAJaWYgKGZkX2xvY2sgPT0gKGZk
X2xvY2tfdCAqKSBOVUxMKSB7Ci0JCXN0cnVjdCBycGNfY3JlYXRlZXJyICpjZSA9ICZnZXRf
cnBjX2NyZWF0ZWVycigpOworCQlzdHJ1Y3QgcnBjX2NyZWF0ZWVyciAqY2U7CisJCW11dGV4
X3VubG9jaygmY2xudF9mZF9sb2NrKTsKKwkJY2UgPSAmZ2V0X3JwY19jcmVhdGVlcnIoKTsK
IAkJY2UtPmNmX3N0YXQgPSBSUENfU1lTVEVNRVJST1I7CiAJCWNlLT5jZl9lcnJvci5yZV9l
cnJubyA9IGVycm5vOwogCQlnb3RvIGVycjsKQEAgLTQ5NSw5ICs0OTksOSBAQCBjbG50X3Zj
X2ZyZWVyZXMoY2wsIHhkcl9yZXMsIHJlc19wdHIpCiAJCWNvbmRfd2FpdCgmY3QtPmN0X2Zk
X2xvY2stPmN2LCAmY2xudF9mZF9sb2NrKTsKIAl4ZHJzLT54X29wID0gWERSX0ZSRUU7CiAJ
ZHVtbXkgPSAoKnhkcl9yZXMpKHhkcnMsIHJlc19wdHIpOwotCW11dGV4X3VubG9jaygmY2xu
dF9mZF9sb2NrKTsKIAl0aHJfc2lnc2V0bWFzayhTSUdfU0VUTUFTSywgJihtYXNrKSwgTlVM
TCk7CiAJY29uZF9zaWduYWwoJmN0LT5jdF9mZF9sb2NrLT5jdik7CisJbXV0ZXhfdW5sb2Nr
KCZjbG50X2ZkX2xvY2spOwogCiAJcmV0dXJuIGR1bW15OwogfQo=

--------------rvdaZ05bnUFFaj27shbwex67--
