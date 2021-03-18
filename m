Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B9D340E1C
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 20:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhCRTVy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 15:21:54 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:35820
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232894AbhCRTVf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 15:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616095292; bh=LMtvQIbSmA3FCs27o6ZxkRY1cXbV3+8A/H1Q24HETdg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=UArKcXlD+8ZY/5mRTH8EAoQ+NRdcI5sSs3SLHZTUWZe2DcwJ10nUjoOO983iMYfVDyITbwY8wr5JOhAp7tjz/L1IShzmqgQZHH0Y9rYKXql5EcqP0V/GmjgfSuZGN1wolo7ssPI2iBMoM+t9RvSa4cHgRGSm1ayvzcLFCYuGAKaN7H70qGC5KyFHl614OCU+feQ0NMA0qpwAtvggz2xxHtzwleXV+qYv07U4sWTInL1+g2lN7WZMkrkPTn/33hQA5pvkqZQYMSnV+uZkPxJixaIDFgHFHX1iT2mlxK41M/NS3XdwlFk5R8tfXxHJ3Djz0NBZQYDTKD4lITNres+7/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616095292; bh=LsV7sFzLyLYkKgynJWVvPUCRaOcMhaRkQcvYlnVgitQ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=b9lh9NEM+01h3VXcvZdeCXLCn1i4kp0M9lhRqsVTh6fAXQgsg/SwhHcU/YEKXxyYWGNDpn1hc7egloBqOSDUYokr5cuAbDwIQ0RQk37D/FgyDd9vo5/tqCJ+w09ghDs2mp/F/Hb2IX+jWIvONTHfO2xnDlCOcdRjn8C5UPcfGCWHd+Ky+qpqoZw4sE/tKU/S42ELHhaTZagAnReRHIi6mLli3JLWq1OucKsh/yvE6cKTS33GUAb+Xle9DorBBUoR9V5fNAmsbgIyNXQNUmvSXgpYjp1RigjyrBfKOk68VQrLAQyXpk9ar2NMzCYIwHG5srNykjJ1MGM//9BQFpL4PQ==
X-YMail-OSG: k47DYJUVM1kQY7woR7P5sBHjfBcoPfQP56PE7riOi1IcWgGIEge9_wQ4Zb4OOzH
 MJfhhCbyXxBq_t6CcEbsyjH4NWwNBVvcKsKPByrIpM78SLrhMfgw_8QTsCbSNQR1MtS5inmf9bRh
 VSgCJ.7pFYnP1zkQB.gT4NYdDh.xWDLO7Mwb5Zn_ASkzj.ld53zCg8I7hFEr.d7epqxk9qWcr0yN
 KullmkQWYn4xz55otShD87_sl6GZW0Iy6RD0usc78P3h9K.Tv2ybppBfqlpFLxuAL_fhudspQYg6
 9OVTC7ldK92VE9NSwsyBbHP1sIn3CjTwbqUvRp1HyklEJY9B_PPcIOKEq.q0igGppQmn3EYvjk6B
 ZQHXP4dpGWIF480JJaIo65_PsXmGyHKAqJwgeOu1Q.YA5jD2JVodi5.DkQ0xcdr2L18lVWbdmmAs
 sncWxxXuZvi7AR7blUqIYumqwOz8d2bxUxRV_kLw84vgZiVN9rkZnWDFQuzsc4VHq.WnZGNHVPvI
 Stdpog0PBpbBciyfsPCDHZoK7aNOb6LEGJJ9xMztVdN7136JGrzM_ovsoCV.dzBhqWgFkss1Luma
 ies2ea2SUELbEMA4l94fzRtCZvTv8nmJ.Jps7Vryc9sKpIbBjpm6xBR1jqsqDhbs4rLlEKL5.xU6
 8WnpNTT_iNcL745oIfqaYVfJZ4TLsg8KMOPSvoHykUZ5zscfy3ynN7CKE_7DugbtD.UdQW4FuFTw
 oUC3T1pP62n1QsuPrNV_1BJVooQJ1W_xmyUYxOvOcgvCjgekDei9ima._hq.B79C3AxUlz11fvpD
 ULQq3GkDyQoGppVk7kyWAeGjy_MpCvwcea1BX1gVdQ1DpvRkzhqklpAGJFTx1DxSIh2ZiQ43AOLY
 V.dTXtRBMvKXXcZgxhqqzShn_rp4M7YHqtIC2qpfXN1AfrENB_Jvtds1lI3Ips5F7b1XvBktb2wp
 xtPGCOlRzgSQ5o2umKK9Y2aw4MUIQEHO7vwQ143Nl5XmIfgK2eZc7M_5fmZThJBGB11DCNbJtU8Q
 cGVJhSe3j28WyJKT9Tt4D4NUkuT3tgIM1WQjtoXykKvNcsEhRyhk7EVyWQC4jazPE0lJlm3aHuVk
 r8lSCLJzhncsgAi8kVNiqEG5bM9WKXRSwfxnAEATEcP7BVAFGPTgSVG_DN2ddMF1o0WXP.akVg1C
 v7ViSozq70tnN1rQlCpicruMqFQJbmC0ivlZtP7UgfeZSR2Nnjau749gUpIWeUxVROOutxRXn2dC
 u33zYx3ZmrxSfuCfOjEFl4VC2lNfLUWNyu.5og5tOTlTBJPbC4nCLPPVsjXP3OB6ezGQbOvqBAj8
 k5hlI0NAXUDs6xPxMdIIBtEz1Oj8EusfwBk3_hqZkDVz3wR28.TAkLWbHq8QuC46hHU1egu867Xy
 weaSo_UesqPQXghj2a1PtoaCBrOIoaR33Cg88M3XSCgiJEOBKV56jbW_5XO9moEhAL5dro1PmNdr
 iVVjRpKQDZx1T9DEBJRDhZQ5T8AIwzkJZL.nS2r05kBs6cGu348zJDICh7XYHBZEeOon4RTRcMK1
 Wplciye0t1AHJd7DLJrgUeb9XOzexBkJvSDw7ReIUNeUzlPYRTv7qZEVmu1s3eOtjcI6vvrTnQ__
 SaXok1IzzLMWdmuvjjz5GhEWK_jYq7v240m5dzgh0hTXc5UgnqFk8mwwTLKgrxXkUPjynrCVYCxr
 MYp768JRgg8M7Gd26Q3R.E_69rB_1w2VtYbuKF1hp8tU3R5oIRz58ap6mYbxDHAeVe8vnLYFKoxo
 hXZJf2aoyca2I6PbzIYDnchTGyJP.BKzq7t.eImkuJf65cSvLzZ9.Aw1l7n15aynSH98NRJSDL8N
 lMJTRmYv8RUSmxfIxveT8N9h6ug3f1tmGf7R1aLedYwti_L0ifalY7Pv3xvzCcRSXWhrLp5UtAsn
 LQI7Or46eOnOUqkzPUBF.GDwgONn4fmzg9nmxgHxSsDPKpHpXOnRQq9IleTT0ESsmcaZcIIv7lt3
 AlhA3xwIY2WeJrcAV3YDExtKRFLwqCqY5Z.kKeg8Dzx0ludCTm7U0bJbzYeIsjD5CYF1oxMiWV.e
 A2lKsE5SdxmfBBtXC8oZt1OqRovmKSLWKSRQdbU9ZgZzAX6MmjUW2R.mYVkUmHpqK59MRtqvlqlc
 XJ1fi_hIm1vUcZsqbuPYeV83vch6nqv4_CfqCT4ecZqF9M8H7hn4f8yucd6QIthS9_ccLejG2VKM
 .vJYin3HWz2Qm1_NoLTRKO6BOjoUpZXAlEVwjv1JWPdbmIXui1FRXtKofmeC4AL9qWD_.HVWIFsf
 Mzh19JhD2fL4zPqfzfzOF7oZc39SRe_Qw433wldMy8118W89VFl3Kj23JClY1VoRIIqVdKHeYpE8
 6FPNhxrBxPVgVJUobbR1SQaiOrLXKJpU8cEJ9b1E.eO.8kbCK0BIC0fOz7TaHpsXFpS8r.ro5ldA
 ywO8L8l1o53lQWdoXyJ.QELLHO1OIkgAiwu1IKYZVXKvB29gPBNcY5fWzxBaLejpbrBtP83I54Vi
 kD1Qsxqsu0iyg6771GP3Scqb0z09nuCwRoDvG.k5QbfpRsTxhqgiVFeFOQiFHn8g4mr3lE39MnP2
 L5Dt_zGpclhOQntFdlim358AAo4f6s7DdMDz5ZQz9f4R01Ud_EH6nfrzyyAi5B7YoYaJFPWo6UDg
 E7._dxZyf5U5NzzheNWeFnPJZQwXRr9TK.dMzSqd_XowEb3wSpx6K8kXYHCMDHO6dD_L83F0YLXg
 o.crmT2zkcBWLXBS3no_iIT.DhAVhAN13I1ntf57finfnNrWqUJOiXF5otL_Ah4MKPSoEmFPh6_q
 mzNtuASebUc2imSzAjj4f0eDPgnOX0O.Ctm9jztJC6wVDcjxVGQoWfGnfkKj98uZDjPsmPpyCFM8
 s356v7yKYb6HvxskhXFxHSIQbbaD9H_oGSH_mv2ZvkYY9ebJoCyhVoczhZqXBPixVJ94FgqHjK96
 kHQwXtIaVyaNAxp9xzuVNxXSenNGTu3JHXj4ET7VPxj_7sCvVu8xljecjJmQu7I__VeDXEeVL67a
 33UlQdTHXeYXTZOF1UF.u_1UEo6glVR1g7aqg84oJiZZVgMsK1w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 Mar 2021 19:21:32 +0000
Received: by smtp419.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 131cad16de69d7b43b6becfe34b4ce78;
          Thu, 18 Mar 2021 19:21:27 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com>
 <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com>
 <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
 <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com>
 <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com>
 <CAN-5tyG95bL8vbkG5B9OmAAXremJ-X5z09f+0ekLyigzibsZ5A@mail.gmail.com>
 <CAHC9VhTwqt0TDEWV97GaM8B5m4qmEwo+BYXYDeMs2D1LtZzUFg@mail.gmail.com>
 <CAN-5tyHdiuiOBX2bkZBGOTK-AMOccm27=qE-AZ_J9QQ00P91-Q@mail.gmail.com>
 <CAHC9VhTZe0azgqt_OSk0cy-nM+upz9z2_i0j1wQQLD8UgbX9+Q@mail.gmail.com>
 <CAHC9VhQyck5HKGKBcv-q70fv6zwTHD2hdfJ3e3SnjqoVty6inA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <dc2f1c70-3436-db2a-446d-aa664e931e1e@schaufler-ca.com>
Date:   Thu, 18 Mar 2021 12:21:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQyck5HKGKBcv-q70fv6zwTHD2hdfJ3e3SnjqoVty6inA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/18/2021 12:12 PM, Paul Moore wrote:
> On Mon, Mar 15, 2021 at 12:15 PM Paul Moore <paul@paul-moore.com> wrote:
>> As long as we are clear that the latest draft of patch 1/3 is to be
>> taken from the v4 patch{set} and patches 2/3 and 3/3 are to be taken
>> from v3 of the patchset I don't think you need to do anything further.
>> The important bit is for the other LSM folks to ACK the new hook; if I
>> don't see anything from them, either positive or negative, I'll merge
>> it towards the end of this week or early next.
> LSM folks, this is a reminder that if you want to object you've got
> until Monday morning to do so :)

No objections on my part. My comments have been addressed.

