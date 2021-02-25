Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63624325561
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 19:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhBYSXx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Feb 2021 13:23:53 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:41170
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231721AbhBYSXw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Feb 2021 13:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614277385; bh=0T4peUwcbcwEgXjJS2/jAD5HegUaEJlGpMurREimV7Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=kKQZ/X2TmDpRAPhkDhQ3y5G4sYAvPm/9AEOcq7WCJrPouTy19Mwgcz9fJMj59FMf0lrdM8UBfv9yjilmzoHOHY4NLIu8XFQsFRje4u7GvVuGCe84u1XNVJMGWj39lmEm2Uo22cWcNs03NGTNq6dzen+ikDpGaOCV9S57+Q7On36yREljgZgfNd8r29tQDBjIU/mr3Ayhn+82wy4jQhUOpf+jeYnCXwRR+6eNsEQH7nTSaWuC05MXCSNjy+glrPik+Kae9R6/enPZo4qqiuBx/pxv975NXv7z3nWQ4RzJL+euScvSBvjxlBAA+6gyN2bOI9iSpK9ZYzaCpq68NauOsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614277385; bh=2dqj5ffl+kRXYra7gY0ezrNQSfi6O2tJoMHs9IPJ64B=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=kEYtq0F1KT3CqhOJNgmGOHSikvVNRnXC9Zf4G4MbDt1o9CIANTDnuPdeT6Ena50YLhZegflvjX2+l5oGjtWDhAbk+90c22bYv5Re6lnWnAwdFVzghKYOh/mqHj1wU/Q88toEiKjw+w2BNfpi8UEZlLisWkww1I4kaDOaELQswv/fEmoFsD3AV7LhTnYsc6xbxINdA7ZWik4wcaV7/wJAzw9tN+il/dOnLOPU10PMd9DAKUfgBWU+DgwMGpnOn9o9FZdbuHKyJaLktpg32l03hDiDqY9/q95zzxHxZ5/NuMT0MnmifUhf5uUAEMnK8Rfb49O2vGcd46sOtP4VqXsNig==
X-YMail-OSG: lEIUr_8VM1kHZU6VkH6eftpFgwZCN78NOVdk1SotisZ8NRqi5lgAq6QPj5uRMba
 JN42ijohlBdpNGQhx0a1Ea4MbpygHSilvTTszVuYO9qSb4IpHsIn1wHu_.PiZNM2XYmoQuXFuryp
 5Ouv9BUqIj5ayet7tdhvUN8pcq46sIhF7I6K7CN2Sl2o9CdyAyxqGo.Khj7nF46FGf429lFXBu1_
 8QDxDWcr1TMU0PjdJQnp6CR83WAZzui4cL9F7c3CqrFkrNuUv6Hs9tBtDpA_9ey.UV4FpY1BOo.o
 Af0xsESxnCX2k6i8xcYYRkKEpoqqKXpq0bB4A3hXeyoThZzItZQmhrzFYlzOjc52KzuQBwRXfmD3
 PnQorTGX9cuFkXCYOc_ZCvJkyfaX_E.6uAdUH0..EToM7vc88OEiM4kCxiOUdIT8YzjRrsDbesZr
 RB6.vSvnCByou_r2ZTiMPfSEchQ4wdl_ip4R9NV8PvpTCaz7X5Tkt.CSZkikk0jn24q315obCyoa
 9CgmZou0iyRiPUeiqY8DPt22Vmp4fEH8OBqETu1RVRj5yfdLUTYbo4la1RlHrvUZUghb0oVBU.q6
 hNc2xzYkA6S6QlGtEQuLocz6BIkr0xm1pT0_GyfQ6J9tjuWOc3_AZaNzpbxDWoG2KJCoZ4dhsfHe
 4aXm8P8JmXYozj4edsFdDWdZKhfy5r3nF8gzS4wyP5mJPLYpeyXqXQ2R0ftdNCaNf6qBOOUZv7NV
 bEl6cjBFLvKjDa4PKPg0ZANVnW7TKHZ7iX1hepSWYBEqhFICEEOXrzPCpz_0VPHkdioK5lNumi.O
 CMJkmnlhzpeKsYoLTpInUuoC92dzB_sbBVyqd1SbrsNEolqblMMaoae2Ul0zKmgggVfH32.Qxoxq
 oC9QVabe1wvgE5d3COtXko3159qPOtAaLzRx5u_eOdIM2VtLxozNN7UbKkuhBurex3bRo5Zv0CYN
 nqQ5bpm__XuFN4G0BCRvGzUjAjMKHF9nz4zPDRVQN6GEd.MY5ZQRcjAovQSaAwcxtZroehm4BiBx
 MP1gxbzyWs0Svyet8at6c_kITl7MSIYrnKFaIghoW.uDq1W6l6b1L5d4ArxO.Zx3E8_0ktvZ4FXw
 WCpUALsikBFs0W0nzDrOnhL6xpjpI0W1sChaBr8UjptZIfrrAiT3ZOaZhpg9TeXw1fv09LPxEdMN
 DbKNI3QCyCww2ts6aVpUcSOUcrfUqGSFXMxqlGg3wY3lraRrVrdVM2UiWEODIbwNLyaWDCdpYnQ8
 lYXBzM8nkEjfFcLXK3rrZLPfhq1G9thfFhbcEa2LIIYA5TerH1DZloVqO0jSTIOOpdZDI45iB4YX
 xKDVmee.y_VBpeP_knfw_MXfG7Z3uY3aqeKzZRBwT_lwQ0FJbv3VfVXcKB8tUVhvk16QuNFUM8Sx
 Cyr6f0xjcDufvMEvD78MWpTLTNh2004VgKsdI6TRD1v4L7dnGKKS5GzMTPl9MO8SSLNrJWEvIcKL
 YmOz.ameeMWbN7JEKoFab70vGiZI_TtD9p0FsC5seUPqPXtrRsxNwjPROz7MqOovM1tRNUrVn2pL
 scf1Tu7N4BQK4YD9_TIp3QwsehsMIcyenALYnZOVC0UGVdzQ8c7cVMJYEXRFJO_W7nd_PwM4bwV_
 hgnUXjit_ar2Fl6JcLakR8rdAC54AFIlDOmSk0mcWjFTl_3EnvK3bulVnUvDpEXli4otTGSefhvo
 x0xS94TPiFJ6rax5jXwV0QFf.vKD6CDhz6R0cVaZaVfg_HoYbtZdwrdj0pNhnvCTDB6eAE9aWBaa
 hxzD.NdYNCkcYnSa5363aKHqGK2w2KEcPBn9.HfTnBXxf5A5_oLVkpTlB7PtE2OiJQxnTwD_W0nA
 XPB_MGdGmHQQpUw.HwI0GloCbdC5M2p1ZdooWH2CqF1JvD8bSi1886cJIjJxWfcraareh0bbnuAp
 c8USlJcVMXEUzJ6.FckBaFoAVFbjOVULC9Pku9rKePj8vrvMZVlOH.c7l.S_ZJ975c1p9p6c2yld
 F8zHIGet8ExPqNvbXhyZkcBL.0raZg125JrxNw_m5BWJSSu8xJUNZe0MgqhMJUGMaPF69ISIhn5S
 zUbZIFIFbfMi5npsNDZwmo1o4OHeC.2OUAIBf84YzyVIhrpHSzyailypn.qA_o2X7cDQ_NjJJmHM
 upkDgsJ4SdFxeCKMP9ylizIA1SBk4S0RCI92DbOjUzlM6u0DqvLtkrkH7yfqeBHXU7XVx7WppkF7
 YQS5u_g0oyGuPuQfv21DDA3_81zHFAtTzyl4gRyD9Pp3OVsKUtDB8Tig6mKbLvFlZn7IlX3alQb3
 mDZaUu_I8Ui3rMDtnfJp_hMFSfS7u.ZaaQOnNNx8Py.SuuWZdYi5VH0vLZO.U0fjqiplYKDbSZBE
 YBGbKWuaIHLxxYJOm9jUpP_dBzHEsFRCey_smHfVAIGcG6pvFl6YYL_gnTrvWIZiwUm.Kn3r6FHg
 z8amEm1.6sa6I4efGX4pcXHc_yyNVbM_bgLSR163B8boooKWYTbMrk42kmDckXLoNPr6_RZgCW9b
 aMB2gm_lHvFSlz4M2XJtQQ72T8AwVyB4Jhzdl8YnolMfFbJ4RgU5aCr_j_nc4OGQfpwmargba48P
 3AOl3dPX2GkGq5xG0h1hau0BHUTJ76qRsIyRtBg.emFOhIQ020QjReX.ENgwIufdTfRLp3azINOy
 xDvFYwQbNFQNn_D5utVmbJX.9VvI308mVZwlRNd5J64zct0DTr9.qSjvhcegZnQsRV_FbFx_kH0b
 iH8L1UogDXlkt3UN2fp.HwOTtp8mJWaBPu2t_O9ttvMbcp7OGvEnLQyBSGVm42zfp3g9HbclO6Ea
 h1E8KnkQOHxVv1QwOtnn7hD4QgQof8yWW.6obTq85ky3_et45yiPnjrp9RnqerHe7fClg84wOORv
 VYEyELEHxuRBlT_L36LjWOvCilqhpmKKR8GUMfu.Pcjj9TWnixuFrX5HGiCFztQO6HqqWwllqStx
 dFDWWpT6jGX8wUvVzcxgHJmtxmNhDRvVlz3wQ04bf8JxGpeMdI4uIH8eIUrNfJPEEWdtmS4CUxct
 Vnet2rjJo8YVX6USzISuGYhpJH8P5Un_l9y4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Feb 2021 18:23:05 +0000
Received: by smtp419.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7335e4c492cab86f3c4354ecc11c8f05;
          Thu, 25 Feb 2021 18:22:59 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com>
 <CAHC9VhRKLBNNfUE0FMgGJBR5eBQ+Et=oK1rcErUU_i62AGhfsQ@mail.gmail.com>
 <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e6d315d6-ee07-bde3-8d87-acff38d43b53@schaufler-ca.com>
Date:   Thu, 25 Feb 2021 10:22:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17828 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/25/2021 10:03 AM, Olga Kornievskaia wrote:
> On Thu, Feb 25, 2021 at 12:53 PM Paul Moore <paul@paul-moore.com> wrote=
:
>> On Fri, Feb 19, 2021 at 5:25 PM Olga Kornievskaia
>> <olga.kornievskaia@gmail.com> wrote:
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Add a new hook that takes an existing super block and a new mount
>>> with new options and determines if new options confict with an
>>> existing mount or not.
>>>
>>> A filesystem can use this new hook to determine if it can share
>>> the an existing superblock with a new superblock for the new mount.
>>>
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>>  include/linux/lsm_hook_defs.h |  1 +
>>>  include/linux/lsm_hooks.h     |  6 ++++
>>>  include/linux/security.h      |  8 +++++
>>>  security/security.c           |  7 +++++
>>>  security/selinux/hooks.c      | 56 +++++++++++++++++++++++++++++++++=
++
>>>  5 files changed, 78 insertions(+)
>> ...
>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index a19adef1f088..d76aaecfdf0f 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -142,6 +142,12 @@
>>>   *     @orig the original mount data copied from userspace.
>>>   *     @copy copied data which will be passed to the security module=
=2E
>>>   *     Returns 0 if the copy was successful.
>>> + * @sb_mnt_opts_compat:
>>> + *     Determine if the existing mount options are compatible with t=
he new
>>> + *     mount options being used.
>> Full disclosure: I'm a big fan of good documentation, regardless of if=

>> it lives in comments or a separate dedicated resource.  Looking at the=

>> comment above, and the SELinux implementation of this hook below, it
>> appears that the comment is a bit vague; specifically the use of
>> "compatible".  Based on the SELinux implementation, "compatible" would=

>> seem to equal, do you envision that to be the case for every
>> LSM/security-model?

The original implementation did use sb_mnt_opts_equal(). The
change to "compatible" was my suggestion. Smack has multiple
mount options, and while I haven't actually delved into how
you would have compatible but different mount options, I
think it's possible. That's why I think that "equal" isn't
a good name for the function.

>>   If the answer is yes, then let's say that (and
>> possibly rename the hook to "sb_mnt_opts_equal").  If the answer is
>> no, then I think we need to do a better job explaining what
>> compatibility really means; put yourself in the shoes of someone
>> writing a LSM, what would they need to know to write an implementation=

>> for this hook?
> That's is tough to do as it is vague. All I was doing was fixing a
> bug. Selinux didn't allow a new mount because it had a different
> security context. What that translates to for the new hook, is up to
> the LSM module whether it would need the options to be exactly the
> same or if they can be slightly different but yet compatible this is
> really up to the LSM.
>
> Do you care to suggest wording to use? It is hard to find words that
> somebody else is looking for but one is unable to provide them.
>
>>> + *     @sb superblock being compared
>>> + *     @mnt_opts new mount options
>>> + *     Return 0 if options are compatible.
>> --
>> paul moore
>> www.paul-moore.com

