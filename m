Return-Path: <linux-nfs+bounces-1034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD8682B018
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103091F228D6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE03C487;
	Thu, 11 Jan 2024 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GsfvUzwN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA23B18E
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704981549; bh=N5C78wTmGtKzFfg9bjpzKH65dW1Z2OeHHp4d7rYGgKc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GsfvUzwN0DwdKPK9jfmuU1PytXJyFlUBNGVMMux2YYTs5ktip7PO+iP3FaMK6Ar/ErE/Qiu2dUsV34KGJRmzPNJIbIVeSrKkUbE1CJaEL60pkOV379jteSAI0sw7m/371o1fk0GmpGeWyMjBK3Sbi7llFDvabVJLkggtQ/KxvqGJBQ9TY1283BGON/VMIX1PY5vfketVkiNJGR2W0ErIuY4Nq6N2D/WKgGgvQ9UqYPcS8+lP/tAGIHXMKAT2E2T/V69VNtzAr1peCxDIcyvYAmtnvaw6e7I48yEsNjVwF2JemvAS7Kx9jbr/7K7Lt8yH1Vart2YHyPztcpb2ZKBg0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704981549; bh=SVDSQhIdLhGgE7+MnCR8tio+IyunA+shp8eVxFds9zc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gQneLFz3qcjjqN4Pwdiq46I5c5vzg8W3VAu1ZuZELmF9TwReZotoW1yJZDyMdzgcZYKwjz2y/saIbu6dsIf2DI9JjQbhA4XYq9R40EQdbeR431OWdmXWNUxB48nTt1tHIVLiCFoMDeV6BcCjyyYtL9DUzX6A11y1ZfWg+uoAQGTD1SQ5KlE47uPavBban8j4xWjJilSIYyeM/WpgQbdfCJPDARF85QCbcV6PVjracr39J7DiSs1cs7ucTe0vLo71mgKJMBQS6fKpV10htQtgFeHmnonQ3v7hwwuF2/fjyvO6hFr1VfSf35piWG93DWS/zkz+cIYnCu9Sd2jXIj7JNA==
X-YMail-OSG: VqZ6pIAVM1lsPmuOtHg_bb5o7NPz5U8OGIgKHuwB.ViUF6Qb8KG8b4XlWtttk9D
 VbcmsbH26FN7pV0iR6JnzakFhhNC5Qgutrnt3ihTyG8aaM3x5NDWZVumgP6FzsH_YYJT3NuTlNuG
 6etuusRv6GVGFAF3at6DpXCZO2X47gEwmDkVxNQq0Sq2o1_ca.VxCn.W0rbEb_V2z.7SWIXyIm7_
 61F5q2z5hvzRSXk0o3Fwq5Wm9w0H.Mx.DikjHf_2twEWx9K6Bkn6hgOfKZJkxn.D0Hl7nn3anOQD
 n2lQF_Gs3raYJ2LUSDvqS32ndnQeAHm3YgJXYdq53pHD8UIRhI_tnq6gQJXDAuOnMYw.A1Kk6PCw
 2k54ks71dVYOd7NsO48Tzdrz0bYK3dhMtQgfxEqLjLUef31OgHyJF8SP8E6f5QgLc5sJ42njsLY6
 61eAt8AHXJ0WpHBsmXEXYBcqWnx5AGIX3AWsR1etM_AowrJUR1_9HKP_m9XCD4YSo7cxPAr_JdGH
 xmKG56Cmtm7zeak5VqCEGxQ5fXHueygA0tQuzxmXLoXhyfShwjkcbK8d5GrHrISySa6s_gyq0OVw
 ryy_Mpvz9ZbJa90AanHc8yJJv.SXNTinSyu2xXyl32b1Fcew1eDWXJPKbgf6u9_iwF1oJeROkYm2
 o1HJQaMTF2An84qxG5T0HE4b9YqESNVv7i9s85xHsFdIouWA3lD4fAqdIuyaXTymzeU0Se_PxpJP
 tLh_sNICuWR62AGMlErtIlzw1aUuWZi64RBXALz7pz_NiQFecqR46h0PyFHfZ6fdzNG4Ylgnoftr
 ZX6RzL_OBOjsJzvb3HgL5_ZikfwF.f.PXQ_JmyayWLApyD6ybY5NLPk7p3jffbuW_KoDVfqcHhqJ
 xGSneVP8EmK6xlZBusX2B3OFFNhcOI_KIcYs9PqSunh1KQ.M0.tb4cLo8E6FENr2zwsj4MenTzAj
 OhQ_3nj8F1HRF_XPneWFm.Hi5mThFHKIyzmYAVJfGz3Mk5czM74EjLQSxHtNqV_8IF0qknImZTV7
 X9xbMRQCJHgV_A_8gnWN2mcCGimcCYyeAXzXmke5WZRxHGPenRn3CeUf9wqPbw7yey1IDan7TAMB
 kVQ5.WkWAiZ02w_7dcNqw.ScjNqe7njvDjC.ZO.RH098lCxn5rRJATuNb0i8KEX.a.7.C6NjSD_q
 UEQVL0MYET9VP11b4KHlM0vU4phRkVavNlMMKJ7hCntnwtWKxHWmiQYnMdmYOQ5uud9watARSn2L
 Z57l0npWP_vcUiYHCxmfUJkB6NyFgVdKLMP4tv0QfJZ8j8yIZ9CKVKDYXLhrlWGO3wFDzyY_y7sr
 eXavc5WT1_adzLsKdN5opXRv.ezwdjMb3j9.GhpgrUvQZArl6ZHLzWCO8kqnqSdIQwOKM1YF4JcL
 Ji9RtCeaGtvviXvNmllNw4vm9OOA8EngHBTj0uHvkWwBdy6dXBBvG35FsBFK4fRDmZng1YnTEaoa
 WNF7Vtn_pjV3KCztTo9XqS_p96Aw94dOQowImIIceQeAKgBZoYBN.dVdK30hM4g1WiBq8U7nCvlJ
 p_ZzvYlxaaVO9Zc8JWxM1DdRIlof7sdKg7k8GJWSH8RFuX05pC2eg9h0phSH68LAQTvsNzjVBkTD
 sdO3Ty0WXFKmRdOavHlYF3Yvp1Flufaq8AwDtoJ1nq1z6EQdp0vUWIPMon0QUy3dcRa3L4BBvP.G
 Isyh_qRDe.gtnTL5K2AjfWBGCEAXVssfdU3kPd4TaIeca4uj5CQu.rivHm.QrRqDK758Gi0JCBCn
 zWMBn6Tc0c9tmT_PT1HjwiiTFEpv17V5Gw39vTh2VMs3tggdqyDfwtpOBAgt9qUErDV6XRl4HPkQ
 kW.hLbKhqtxkhGgvLJgBsUm_UcMDzwNmKYYS29Eir8SQ.Acg0HYNoGTwQVhO06I3EZ3rJRdDo5JI
 EZ8sY5vFWJW.nsEx9_sd4TUEGZIEmPYRrpPn96nX68LxxAAcHj6QrnTpCSWY_dReOkZnZkzI31Xz
 IKuYPiHZFrM5gOnbJWDGfIXJNgFJ7jVYGbfgBM.q0uXd_Lrj3WdoXIhhSflIt0gx9mBG0U6rDG4L
 PKIz2uo4JMw5R0d7Z5M8GFJD2M8vC45KATvzFwKNHsZsWZb2cZQGyGhY8xE.qLf.MiqlWIST2yd7
 kP6ZoYwJQotJuNIdl6zT.xzzImJ.R5c4VoHPCOpORT1P8bcMUvKq2Xo6FyEzL__b6rN8Vo7ltM90
 yt0SzRI10JkYeEYcp__sFiQcwcyW6MC622nZRYg5HZj0iyXpHYkc8FA--
X-Sonic-MF: <email200202@yahoo.com>
X-Sonic-ID: d96dba1f-f098-4ede-8a35-cd92d86e2513
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Thu, 11 Jan 2024 13:59:09 +0000
Received: by hermes--production-gq1-78d49cd6df-k96gh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID be72881b0d821ee080898b675639d3c6;
          Thu, 11 Jan 2024 13:59:03 +0000 (UTC)
Message-ID: <bbfe6944-a7f0-46f5-8a30-79eccf84664d@yahoo.com>
Date: Fri, 12 Jan 2024 00:58:59 +1100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] After kernel upgrade 6.1.70 to 6.1.71, the computer
 hangs during shutdown
To: Greg KH <gregkh@linuxfoundation.org>
Cc: regressions@lists.linux.dev, kernel@gentoo.org, stable@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <58ac38ae-4d64-4a53-81e0-35785961c41c.ref@yahoo.com>
 <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>
 <2024011127-excluding-bodacious-1950@gregkh>
 <3b8250ac-79e4-46d1-a508-5773e6330fb4@yahoo.com>
 <2024011114-attribute-semisweet-788c@gregkh>
Content-Language: en-US
From: email200202 <email200202@yahoo.com>
In-Reply-To: <2024011114-attribute-semisweet-788c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Greg

Here is the test results for the latest versions of 6.6.x and 6.7.x 
available in Gentoo portage

1- Stopping NFS service failed but, unlike 6.1.x, it did NOT hang.

# uname -r
6.6.11-gentoo
# /etc/init.d/nfs stop
  * Stopping NFS mountd ... [ ok ]
  * Stopping NFS daemon ...
  * start-stop-daemon: 8 process(es) refused to stop [ !! ]
  * Unexporting NFS directories ... [ ok ]
  * ERROR: nfs failed to stop
# /etc/init.d/nfs start
  * WARNING: nfs has already been started


# uname -r
6.7.0-gentoo
# /etc/init.d/nfs stop
  * Stopping NFS mountd ... [ ok ]
  * Stopping NFS daemon ...
  * start-stop-daemon: 8 process(es) refused to stop [ !! ]
  * Unexporting NFS directories ... [ ok ]
  * ERROR: nfs failed to stop
# /etc/init.d/nfs start
  * WARNING: nfs has already been started

2- Shutdown didn't hang in both of them

Best regards
John G

On 11/1/24 21:21, Greg KH wrote:
> On Thu, Jan 11, 2024 at 09:10:39PM +1100, email200202 wrote:
>> Hi Greg
>>
>> I'm sorry. This my first kernel report.
>>
>> I didn't test 6.6.x and 6.7.x.  I use only 6.1.x.
> Can you do so?
>
> thanks,
>
> greg k-h


