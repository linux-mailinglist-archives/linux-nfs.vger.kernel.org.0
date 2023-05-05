Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804B16F873C
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjEERGd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEERGc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 13:06:32 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68331150FC
        for <linux-nfs@vger.kernel.org>; Fri,  5 May 2023 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683306389; bh=7i9taNSl1pK4F+ZUTLC6cD2jSDuysK5MLrdEM6LMvWM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jT/UB/5eAnRnjcEKEjixZTXfyle24YEQY16byGXk3RF0O0QOJnztg6Zi7sE3QkQTmHy3fio680gTR0Ny/jWq8ROmU5oWig5IGNHWF7hl5ZGEv913QPfpr/Pz5yHHGRSNXyoY0kej8ToHxhb7AjaKvbXjxNnXpovWPOegx1z9U/DSw3Z8CdH4Zg9qMLPhT8qjcJkr/LSghdm5YeXLwds81O6KyXJs1qbTJRZFEXlZMKggMWSfBkfZIUSuRQx5ycrcbiJwLWp8/SSFFebz8Vodg+JsrjPEcXNqD0z5c/c+6xL54+MdvB0w5a37sA8vlU25O9NdmfmFKFwe1TeYYUH5Pw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683306389; bh=Zv3CxJ2o6GlOGg172TIMDrltOst+VcPsYSXKC4dU4ME=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bvZ7i5Sh3JwSL8ngNOLf2R1ngmiveYcjPi1+727+8i3Vbk0HzDdF/mccAKRTn9Enov7zEmCju3q6oVmPj3JgfF4F6iZjlU8/dtnNSX7vRQPtqRjCAe4rXxeGf8OnJ3RdZaMPB5siWyVPwEjKweL0AID+wMkTSyCFYiWtmttWm2tS3jzydKc2T6NNktE1GuPWcpZywKDb2xTJQ8d51cLqeHNkFpelCfdDObu0fCcPtuzklWO5IsNgLmX/GBASwwjSbqMLMIZFdeU9HJ/hGH00nQghPf89jltnc+oJsdLmSy5uBu18gIi4aTPzXrI7Pz/7XyMj8LZBkTdRLRh2aQ+q4g==
X-YMail-OSG: oJSLLUEVM1kJh2Pd5IXHAkeskQtjZc0L0yFDFWhjHIRPYSHPDOAhFX1RRVw7KzU
 k7AHDxRy.H.hWEgBE.o9HIb20tsrN8HIbpnGCFYUxKcb1Ot87TGpsSqAfqFC_qMoLUyL5qQIiC3D
 0.yRwFHBkgqcA7G4pKWg7nyQpnrMVfoJx5ug4dvFfChfwpvMO2_Vh4KGrp5NRIG8RZT1zum9zWcd
 YiZmtdhlzDc4WZi97Sn_Jm.uzs4c10W_27tR5jZ9FADKC_Mvtev5cx3ZwRTjXdeVyu4H5r7x.8CI
 jOGW2UmIiGKQDMuLeJXuh6jTd02E1PD6F3Nk3OtUfTtmGJltlLd9.g8rrMvcD6Np.W.Cxo5zjOAl
 .Fe3FWWUCIsXyMC0AfaUZV00iuJSjawxS25ueL9h5isvYnuyOkgSbHrDmEzcTN945NAya6aQZLZ.
 63O54Jlp_oq2b0brEu9SeMwq_GrkamSguBPJ1DUK9H1aQKx4nkf8oFfU7vgZWz5zBpHAsYj60q2t
 DsN7yz8F5PHIAHl_BDO2GF0MPAcZbf3tLZh177eWWC59asirqhj0_UMxZ1CdKLB62RAinGpMv6sn
 QBKb8Rd.Ri0QPHi2g1doae7Hrj7j8LDr4tKHjZyPr8cOgnkd6Y9KrbHfaeoBD1NsvIwwHc3EkkN6
 o22TWCchMXwTCRtpLmgoS.HxlfoXFsyH6UXDQ9YnQjAU3NgQqyRqaujgqxcKMX0K_yddBPVMCWZO
 b_eKRCIiF9ZC1L5GjRZYP_oE9c487wQnxH18NmBlR4oV_2phLzH3Y6KxzWlm1wQJQKmvvE7nQQBd
 KkJC9aOgIN9istOndk4HfLwkvdgczRSRd7jArawn0UzBGeRXsfO48Dl9eUkIgGDaBAAhe4rIaZ4v
 Zqyk4A1laFngehigV46xAw7s7QMbcgMzZcuDBEHuInAWgmTlSc32lQMLzLFBqZw2WEegMu.TgCl5
 V6hzjCYw7o5a8O3YCTU4h2wZmUa3dQtEFbbZOg.Uwu74kDTwQPniky7ROLMX25sdazYDTW8LVwfb
 0klWumQSX4DwX0L_ZoJfaj_bR52JJyDPaEy0Iz1KSZ_4a72VP_.FI_1SHRwh.LNUY4yFdDoysFGY
 kdEJccRVSEgVqmmZCO9QneVe_jvq8YCagttHgkDYhDvJfppkN7PEOvacCbhReLthuMn4ZSfyc_3J
 xZpJZRgZLBsb4r7eLSUuyIKYcmiZ_H4f_3.IFn_E_7qW3wJeqyjROk9VezZGAMpL2DCaka967Zgn
 xWL8OPtkQHkqd5h9jjr9UrVQgn5wxW2zY2JdHb64hBFqs9TsLo9sgL3fvDZpAbl6PdOzWn15w_y3
 lVC7QUoQA9oglnE2jiSLtYvSMxVgD5I1WLtlzG76G3rHKFtP7GQANK5qA_22mofpe7DEmkL1E05q
 FyJhm626LlfO7L8qTTmRd22MZr7oRQWcXqpCAA142a69eZmJfDEqYmgf8S0E3twS_IIZ5PQMOVLF
 u4pDF72G16YFroBf_RpJT9aizCwXsl0lGBk.ua2exV.5rju7OBRfDW6cMiO5K_N4bXY9oXJN1V7d
 qu66xQSkV8T8a69gYOEOynzrLrTEgTMM4bPwMHVrz73NPGfPuP5K4zHuwNPn.WeATsXMQ4sMJLrU
 2zr95Ilj.DQ93dOv50D_BTD4VfTbpZvus0qZhr49.azuKtH69pIQgLRh_.B.BTIOq.gHBWEqnRri
 hEBgwlpydt8D5DO46ppi5UI7o.xSX4pA6jIV2lI55hlaW_Ddjb40WUbLgwyli6TxuO7XWcNrY69c
 CBwseOKR4Wpb2us4A_K.ptyQ6RXXMpypSs1sqwLqSVvyjyHClf5s5uhZKr.KreUOyPNnNPOHtTL3
 MD85icQnpCpEgmxdGUkvGrxTto_nql0dwxAGfxq2A4Ji5HDSvu5fzZnwkaCxq21cKZV6jLCjcuHq
 L7ZFwfN5U9jdO4LDOrwNGtG_QvlQGrKZXucoyyVYgFW6W160S1dvbjipPEu5YIySqteb2Oiu_2oM
 UXtkQUDPbjUGcUwxMiPfWTcqgEnvlFxMeD7bIXImHowfzOU07Ob4Qj0OCCFnQNgU4JheB4YpeE3t
 FlWsxDyS..UeoMwY9hLqXmrSX_ELymJnLNXOT2kfIhdbtd3yQ2pDgs04S8B.JbSxs26GEp9dBwkS
 _IIfBflHNfBh1sJpK8n8i.LHWJw_IgAMwwVUECNohTVXYshJscMwCPup5lrkVNvScbRidD3vwlsC
 JFgSVGfMkgJq4hI.nkADqQs8f518fuzBO58wIGxloJ0vnyzJ1ktlLjndmA_Q.TzBUY4klVRYknfu
 oVVcm54ku
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9e4ca756-5097-4cf3-adcf-6eb9df6c41bd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 5 May 2023 17:06:29 +0000
Received: by hermes--production-bf1-5f9df5c5c4-nnnf9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 782b7de64ba8de91d80f1d4e7c809e9b;
          Fri, 05 May 2023 17:06:27 +0000 (UTC)
Message-ID: <8361cbdc-5eed-b7c5-2ba8-d6be12c8da88@schaufler-ca.com>
Date:   Fri, 5 May 2023 10:06:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: NFS mount fail
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1923bc2f330f576cd246856f976af448c035d02e.camel@huaweicloud.com>
 <d34c30ba-55cc-8662-3587-bb66e234b714@schaufler-ca.com>
 <6b5f941a4dd57f357f942df4051ccc9995b4ba15.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6b5f941a4dd57f357f942df4051ccc9995b4ba15.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/4/2023 11:53 PM, Roberto Sassu wrote:
> On Thu, 2023-05-04 at 17:59 -0700, Casey Schaufler wrote:
>> On 5/4/2023 9:11 AM, Roberto Sassu wrote:
>>> Hi Casey
>>>
>>> while developing the fix for overlayfs, I tried first to address the
>>> issue of a NFS filesystem failing to mount.
>>>
>>> The NFS server does not like the packets sent by the client:
>>>
>>> 14:52:20.827208 IP (tos 0x0, ttl 64, id 60628, offset 0, flags [DF], proto TCP (6), length 72, options (unknown 134,EOL))
>>>     localhost.localdomain.omginitialrefs > _gateway.nfs: Flags [S], cksum 0x7618 (incorrect -> 0xa18c), seq 455337903, win 64240, options [mss 1460,sackOK,TS val 2178524519 ecr 0,nop,wscale 7], length 0
>>> 14:52:20.827376 IP (tos 0xc0, ttl 64, id 5906, offset 0, flags [none], proto ICMP (1), length 112, options (unknown 134,EOL))
>>>     _gateway > localhost.localdomain: ICMP parameter problem - octet 22, length 80
>>>
>>> I looked at the possible causes. SELinux works properly.
>> SELinux was the reference LSM implementation for labeled networking.
>>
>>> What it seems to happen is that there is a default netlabel mapping,
>>> that is used to send the packets out.
>> Correct. SELinux only uses CIPSO options for MLS. Smack uses CIPSO for
>> almost all packets.
>>
>>> We are in this part of the code:
>>>
>>> Thread 1 hit Breakpoint 2, netlbl_sock_setattr (sk=sk@entry=0xffff888025178000, family=family@entry=2, secattr=0xffff88802504b200) at net/netlabel/netlabel_kapi.c:980
>>> 980	{
>>> (gdb) n
>>> 771		__rcu_read_lock();
>>> (gdb) 
>>> 985		dom_entry = netlbl_domhsh_getentry(secattr->domain, family);
>>> (gdb) 
>>> 986		if (dom_entry == NULL) {
>>> (gdb) 
>>> 990		switch (family) {
>>> (gdb) 
>>> 992			switch (dom_entry->def.type) {
>>>
>>> Here is the difference between Smack and SELinux.
>>>
>>> Smack:
>>>
>>> (gdb) p *dom_entry
>>> $2 = {domain = 0x0 <fixed_percpu_data>, family = 2, def = {type = 3, {addrsel = 0xffff888006bbef40, cipso = 0xffff888006bbef40, calipso = 0xffff888006bbef40}}, valid = 1, list = {next = 0xffff88800767f6e8, prev = 0xffff88800767f6e8}, rcu = {next = 0x0 <fixed_percpu_data>, 
>>>     func = 0x0 <fixed_percpu_data>}}
>>>
>>> SELinux:
>>>
>>> (gdb) p *dom_entry
>>> $5 = {domain = 0x0 <fixed_percpu_data>, family = 2, def = {type = 5, {addrsel = 0x0 <fixed_percpu_data>, cipso = 0x0 <fixed_percpu_data>, calipso = 0x0 <fixed_percpu_data>}}, valid = 1, list = {next = 0xffff888006012c88, prev = 0xffff888006012c88}, rcu = {
>>>     next = 0x0 <fixed_percpu_data>, func = 0x0 <fixed_percpu_data>}}
>>>
>>>
>>> type = 3 (for Smack) is NETLBL_NLTYPE_CIPSOV4.
>>> type = 5 (for SELinux) is NETLBL_NLTYPE_UNLABELED.
>>>
>>> This is why SELinux works (no incompatible options are sent).
>> SELinux "works" because that's the use case that was verified.
>>
>>> The netlabel mapping is added here:
>>>
>>> static void smk_cipso_doi(void)
>>> {
>>>
>>> [...]
>>>
>>> 	rc = netlbl_cfg_cipsov4_map_add(doip->doi, NULL, NULL, NULL, &nai);
>>>
>>>
>>> Not sure exactly how we can solve this issue. Just checked that
>>> commenting the call to smk_cipso_doi() in init_smk_fs() allows the NFS
>>> filesystem to be mounted.
>> Are both the server and client using Smack? Are they on a network that can
>> propagate labeled packets? What are you using for a Smack rule configuration?
> Only the client (Fedora 38).

Does the client run processes with Smack labels other than floor ("_")?
Are you using any of the Smack mount options?
What value is in /sys/fs/smackfs/ambient?

>  The server is Ubuntu 20.04.06 LTS and uses
> Apparmor.

Because the AppArmor server doesn't speak CIPSO you will need to identify
it as an unlabeled host. This effectively labels all communication with
the host as having a specific label. See Documentation/admin-guide/LSM/Smack.rst
for details.

>  The client is a VM created with libvirt. The connection is
> the classic tap attached to a bridge.

OK, does TAP on a bridge support IPv4 options on packets?

>
> Thanks
>
> Roberto
>
