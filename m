Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE125F2FE0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 13:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJCLzx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 07:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJCLzw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 07:55:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74124F1BB
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664798144;
        bh=ps0xvQSGGSrFzSQ4xRTb++5i4vCcswlVNvmAjvc7TEk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DrM2Gji7Eh/Wg+L3FHxQWSyDs3ic1wwnZjORtaCqhwhSyBaD5ff2uFIaAn12f5ijH
         dzZQalQp5RhfY302C4WHrNT2zjl0QcfUQy5M4Aw/b/3jRAE2T8QB8Gcy+pVpkf+H6g
         0BOzEx4BxTmviO3d/GRln58s0Q2I52rco/tV6NcM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.99.12] ([212.126.164.126]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1pRns11BmD-00vdRO; Mon, 03
 Oct 2022 13:55:44 +0200
Message-ID: <8550c032-2ef8-4ddb-19a0-307777bd9645@gmx.ch>
Date:   Mon, 3 Oct 2022 13:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: nfs4.1+: workaround for defunct clientaddr?
Content-Language: de-CH, en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <39bf58c7-47d9-744b-6d26-d672aa713024@gmx.ch>
 <8cd63730f7b5f3e2aa3bde98587de0c6a42b384b.camel@kernel.org>
From:   Manfred Schwarb <manfred99@gmx.ch>
In-Reply-To: <8cd63730f7b5f3e2aa3bde98587de0c6a42b384b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A/5rTXgEUn5C1mnzfdIpAz5DKUAjRfTzIfZuMcyXsWz2+DhkJqr
 vTPZnbwXW+1Rcez6p4CqymMYYzaveuRDTvKy0zEwFwRJb8BywTA0Au6SuJ8YQrH/4UvSylS
 V7rWOJVK2dYtTT+G0j89kU6K7qodE9O81cyES/UNpgYYPOkrVzWRdqWRKma5CZCA15Xpmm0
 SXxMIXLV/mVMIo0maiI8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wijVg65/NXs=:5MgMlT8rIOqY7Iuv2eiNo0
 gaf49Y6V5n2GHa8F4oav+Dyrd/ruu1BJren2q20JuprACsBV9sycIscjR+bvdYoAGeVk/oXfH
 v8sUH6vFRvrLqBe3qJDOyiQLgVT698/I88ymsG1ipjzST0LyyBWxfqPjyNQcfCQyn3vMsq1b4
 p/5r8vPlf7qx/z+J/RWv8Q+WH+sGLBhecR4IMbCHvOe3aha95en2S0ZF7lISAgD2iXRYJctX2
 B6d5xReNqcXrmkxL8sRJ9ztkq/gowCrZx9LVtitKITXl7BhsEcp+kliYaxoqfVNy8MDKC2rPN
 Q5sNZfCPuy3E5ITBYjN+hWFI6zG58dvtvesLufECXoX9v0QFZ6CLE2vbtCOU+sxNlDesIWsJv
 cPpItyoP3NkH8ktyDVNZB3iyhD3Lg+g1Pidt3LSxDEMYjysU5KP7Zj7mE+W0bhESlCgSIKs5T
 lLqTM4d58+OzuMeMrI9P3jnUHQih2LAYvSXBYcHMqcnV2tW/r5o2VfzGQlmbB5k5eB32NtOwK
 vyt3d5J1G6dGOaQjog0uMw6X4nP9WUN/u/sK9TBEE/uilZ9fGCPRIvwLE7fTga/1YMNffkjkp
 uBWbedcdWPyLSkTOmIxMB9/XquEeCaTKn95tPzp+Tx7sP0BHOM7YnJUR+qvCW0uwKM3rwBJFO
 hOW8LKnODhvr2VYbNgLerxnSA8Q1iz9pvEdOkXggP9ZyJ6YWf055iKVJcVhZjGvKmDtmZhuiY
 k7yHBle0rMeH0K0hSBaEGUf5DrzXwGylNIyOezRpbsLhlxZ0QtuNVmtJGGqapDZ3lILI0ETBa
 6gmdcSNYN9PEatDEBa/gHg8gNxritUf0IgKRWqR38hvHaJOAlTVyvttzJNbspAl/e9XfiRGSm
 2fi4TQkzsgBQDdGzjaE0d+ZWczHnDbdSUwDx1Y9vUnHSTfSkoW2OM8VRA/ZojNAQ6TTG9iw5+
 M3uXrp05XgMnuorMu5ALhwx3kKE04Fl9C/WxVs3PrQXcGYEL9eu3sxW5yLSF6hEa9ngbnsEH1
 etmNM+XSG/9VsyJcnEdW46Hd259xPWOEBCyBnSoL51s9w3A7e1+mYwBKA6ygkIYiGN38dfII0
 rwpaXCvHOhaM5XsLU/Xy48XnsVYbeRPAYK8DvDqFIc5hyqS9ZRblCgTy+sIxPfRHcCKdOsq9c
 uAahfHjBOoftPojg6F0a1zs/GD
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Am 03.10.22 um 13:39 schrieb Jeff Layton:
> On Sun, 2022-10-02 at 14:35 +0200, Manfred Schwarb wrote:
>> Hi,
>>
>> I have 2 boxes connected with 2 network cards each, one
>> crossover connection and one connection via LAN.
>> I want to use the crossover connection for backup,
>> so I want to be able to select exactly this wire when
>> doing my NFS backup transfers. Everything interconnected via NFS4.1
>> and automount.
>>
>> Now the thing is, if there is an already existing connection
>> via LAN, I am not able to select the crossover connection,
>> there is some session reuse against my will.
>>
>> automount config:
>> /net/192.168.99.1  -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,clientad=
dr=3D192.168.99.100   /  192.168.99.1:/
>> /net2/192.168.98.1 -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,clientad=
dr=3D192.168.98.100   /  192.168.98.1:/
>>
>> mount -l:
>> 192.168.99.1:/data on /net/192.168.99.1/data type nfs4 (...,clientaddr=
=3D192.168.99.100,addr=3D192.168.99.1)
>> 192.168.99.1:/data on /net2/192.168.98.1/data type nfs4 (...,clientaddr=
=3D192.168.99.100,addr=3D192.168.99.1)
>>
>> As you see, both connections are on "192.168.99.1:/data", and the backu=
p runs
>> over the same wire as all user communication, which is not desired.
>> This even happens if I explicitly set some clientaddr=3D option.
>>
>> Now I found two workarounds:
>> - downgrade to NFS 4.0, clientaddr seems to work with it
>> - choose different NFS versions, i.e. one connection with
>>   minorversion=3D1 and the other with minorversion=3D2
>>
>> Both possibilities seem a bit lame to me.
>> Are there some other (recommended) variants which do what I want?
>>
>> It seems different minor versions result in different "nfs4_unique_id" =
values,
>> and therefore no session sharing occurs. But why do different network
>> interfaces (via explicitly set clientaddr=3D by user) not result in dif=
ferent
>> "nfs4_unique_id" values?
>>
>> Thanks for any comments and advice,
>> Manfred
>
> That sounds like a bug. We probably need to compare the clientaddr
> values in nfs_compare_super or nfs_compare_mount_options so that it
> doesn't match if the clientaddrs are different.
>
> As a workaround, you can probably mount the second mount with
> -o nosharecache and get what you want.

Indeed, nosharecache works. But the man page has some scary words for it:
  "This is considered a data risk".

Thanks,
Manfred
