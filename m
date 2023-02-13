Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC8694E74
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBMRwn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 12:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBMRwi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 12:52:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA714EA1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 09:52:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTO62a2318sS8R44XjuFIwqnu/hfwvMGlaqcA2Fwlp+t8d7xVcP2xxUyDIud14tZRJtHHpCsGqZDKHBHjpsHorb4pUB0JaaOEPeTXYJjCnRR0dDSqZDI0VNk5n/HgjIkMsp9cjsoQLHlo07ni0SxMbOSN1UjigRqK8Weh1zi+1+1sPg5CAntDdrwwbn8tA/8fZ+HFfMlMpau/omdCM9LA9Hg6vkVKDDgSu6ugeUg18VBR12zHAiy3hTjamDi/d9/xpZciFhyNbB8cbMsmlc8m5LtqgqcG+ZAY0hsau1HWCl05NUFBJuIELTtPhyeq2C0viFw7jFgxG4NkhNkv4BO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2om7Wx8S3KkCP2UmBGd6ZwCwGitbfVZwLJqI/VSw68=;
 b=Wljj2hBC9mkMI2vDP+578TiuYxJBMuyHE8vYMCp6iN1KSTngPw7e6f6LaQwbgh/ZdQ8eHtSW9NtVc3rp9OM9o1qWacTuvAW+L8qlhojvtREGDCAOVaZOyroSKv6D3/mwlErKiDs1D0GORQ9Fs21PQTYohF+H1mI93OokfB8BZGNQ+i2kJ5kBSBGkqGy627WvYSVETcXHv5sBXtsFTMI1v+KHaiGOrSzBbn2B5R4NunVSsDMLvaOGfEps2y6Ae3durqymqprnaLEOIC87LSTsci5jtfpKeEQ69cckJ9LceU6cqVtJMEPcoqiOI75WM3P0vVCRMZ9FN8r8ZMZsPOd+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2om7Wx8S3KkCP2UmBGd6ZwCwGitbfVZwLJqI/VSw68=;
 b=r4YVblPWGdzvJPAyxF5NItTmgO2ciOq45B1qDQpSihsvybcOukYCssrK7+W0uSQoTdrE4H0wIUtYq1VyZu5+xPZ4u0jmbSct2CRJsBtnkNABYRaQuKYPhVWTOiEISK6DTqBmcp0KTw8kdJPMFlhWw9JRvOobgnQlSX0rNNdxj8U=
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by PH8PR14MB7059.namprd14.prod.outlook.com (2603:10b6:510:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 17:52:35 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::b695:d955:65:f188]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::b695:d955:65:f188%7]) with mapi id 15.20.6086.019; Mon, 13 Feb 2023
 17:52:35 +0000
From:   Charles Hedrick <hedrick@rutgers.edu>
To:     Wang Yugui <wangyugui@e16-tech.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: question about the performance impact of sec=krb5
Thread-Topic: question about the performance impact of sec=krb5
Thread-Index: AQHZPqeK1vTr9ZprgkOSoO1Rn1K+967NKnj9
Date:   Mon, 13 Feb 2023 17:52:34 +0000
Message-ID: <PH0PR14MB5493A75DC8E617230D426F09AADD9@PH0PR14MB5493.namprd14.prod.outlook.com>
References: <20230212140148.4F0D.409509F4@e16-tech.com>
In-Reply-To: <20230212140148.4F0D.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|PH8PR14MB7059:EE_
x-ms-office365-filtering-correlation-id: 4fcb81b8-ab91-4185-f4eb-08db0deb168f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ia6ZyqK/g4HUl+VKO6FtI5ef1YFFUMG028lYf7pYaGs/CmMgqC4mSv41BF+OeZqf9OLp7fiQtl9YHg2V8klyNm77YbJP2AQATltHAyIHPPZBe5lt2aKh0j6xTOvQ0WMbcVnJR2ccZIuthBWCxQS+es1gATy3xnYiwHQgIwBjAB2VSZ2PM8r0t1/Io9z9nkCDgruwzmpDuJEWF1SPZijnq5r7ZzuI8wNuixSyXzdvKVldhru/FOZmCqgVuGyqWbQ47cIQfIYhAyrc5vXSP3zGm09l3lQqAGT6ehaRhyao6K9htXYKn9PVgH1yrFOzQ2idb878Th+aVSkZcAO34rulL3bF6vh1zKrySZlV1/os1QZRP8gkQMIjeVNR0TD22jxR+cPPrtu7IkIsnG4sWVzO87pDGR3iBDWJWxFYcL6knFHZ+pVimHk461/zMWRLbES3V62zBi6le39SfcdFz5Reuh1vyCEDWsLojmWCC62Yb8AS/f9aRve7v6+ZmQ5CfslVAVOXUJeq5uol6QFL4s4nl9+2zc/72JMhZMbC8NLhr5kDVVpeNSj3Iwgle7UCnskP8v1VBCaHQwvPUn5dntRjJA+BqYp6WRldOMjMB3FC/bSlOB3wz9444+30UVjRpeKL2mMg3kiEmx2AMZnFLsegzzA7+xcwSCa9lfa6pWmGUoL0R1WwL4h7U7xFdS+r72b1seTLfHXCvozj7+DMWxdd7Z2n28kRk9NzKxYB6vaKArM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(75432002)(478600001)(966005)(7696005)(71200400001)(6506007)(53546011)(9686003)(91956017)(186003)(52536014)(66946007)(41300700001)(316002)(76116006)(8676002)(64756008)(66476007)(2906002)(66556008)(786003)(66446008)(110136005)(5660300002)(8936002)(86362001)(38100700002)(122000001)(33656002)(55016003)(38070700005)(41320700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xe1XOOwGVqTKQOr9njeZ5Cq9mNgyC/ioRhw0dzyx67htVZrI55VzM8OaOg?=
 =?iso-8859-1?Q?wzXQ29fOcEWecIZECeagiruRdlOtkCaeitMn3uIyT7Ch2ipxIDITPkN4KM?=
 =?iso-8859-1?Q?kNyiKoD0agaEjRZYmaDBNTuR+qkoH/Dr4b0yhddOQb7vwu0aesqJtwMgS1?=
 =?iso-8859-1?Q?IksOmfuHxMfHyyXrJahZ4yclbBXUxquP+YThv9NBKWbAZdM7tmYsei/dDt?=
 =?iso-8859-1?Q?eXOXPxItG1RTeNbE3rEUO0LzpmHC+KZ4WwA7y89mHw00juG9lpPYv42+eO?=
 =?iso-8859-1?Q?OladCCTR15j7uNxpYrYJ52WMj+n96hI903hzTx1SEDyw+NIfNYzZ2TGSuB?=
 =?iso-8859-1?Q?EeBfIKtsZg21Z+KinS1G199/AisoVdXzXpN6rEJ3IbpnNDtnqkiPf/ydf2?=
 =?iso-8859-1?Q?ms9ncbC0OotHcbgrMhRJlPt9ae2FqDK83EWOM/YH7anROweilek6Tp7g/l?=
 =?iso-8859-1?Q?WGVkK2iZfnjKjz1BCuAbBpkmDDaAiZ45GgiLXFdachRJVhLQR68cv9ejEk?=
 =?iso-8859-1?Q?Sy/HX9tyz7MrR5YDYGlfjmuol0stDQSUyqpZSqaMS8le7jjmjUCSeEzfd6?=
 =?iso-8859-1?Q?ltEjuad7ntu0hB7ctZNkP4/Qtd3y3ZSU8o6qfqDlQAMDLlXXtQQO8s16JS?=
 =?iso-8859-1?Q?/pz3Qig63W8L39GGWyv6tvUXcaAjlnWh1qGNFIqinejxq+Zm6SWHys/f7+?=
 =?iso-8859-1?Q?lIrP/sFVEUcY/jLzDEh/F43Bz7WbmUKfyP9oLIkvLIZtArnVTquiCIRgb2?=
 =?iso-8859-1?Q?2TZYZHgo7if2OM3K6l7QgupYbKuL1VAGs8sBm7Lw7zcXvbm5a5dw1suIzU?=
 =?iso-8859-1?Q?p8m/L/0hlIdMekOw7kSG3RrMEo+/lAXwkZO+AI4hTljdKwvlarTuybdoyI?=
 =?iso-8859-1?Q?ViIb7ZynkZ1mXNCPl95A7A7k/RvwmCbr+E6T7WmkReU3D/m0Howlw9XFTR?=
 =?iso-8859-1?Q?4P2n/lgqu+FYcUaeD0Q8Ngw0azwA5z6DYA8IevHOcUHsviIz8mWUjZaA3N?=
 =?iso-8859-1?Q?IHhAV06sVx+pAPLOpFZkHn0U3Xmbl4CxeyMzVX4DcNROyYeICcDpfJXBVt?=
 =?iso-8859-1?Q?27nuqbD6DewILc7gYLkL3SHv12Cf9iv6pJQo74Oauvfl2G38bQNs7uLv3x?=
 =?iso-8859-1?Q?jkQnxwS6Z9ku78Svk0xR9XMilACT1OFMs0PzRY6s1wG1exXEwztkyu9Thz?=
 =?iso-8859-1?Q?9fgKCQDDjkOPMdd14auSexLnhBbCCx4ow+V+9Pf9tTSSVrY4sLU3bvC8sX?=
 =?iso-8859-1?Q?uwVcU5wlZVZJa94aY4jBQWs7WAS7aunoBTAfkFxUP3MWzcOem4aeSAVmGx?=
 =?iso-8859-1?Q?OVGvUWPNR+vDKuAuTo2/v48mE8q1/kDawKqnd5Q8KY31/XOkmyuRJB25Us?=
 =?iso-8859-1?Q?7eCw9u7VgQwbvpd3uEGh654sjzNDN/h/SkdWfmGLbzUMwqdLTU6wFsP20S?=
 =?iso-8859-1?Q?rP+T2asat9Lyr/MV2SK4bBygu11b5HMULY6sB+FFZYjU+UaFrbnAWtExPw?=
 =?iso-8859-1?Q?cROvmJC9hUBnnXnJgD9pKYKzxjC5krWsHGhKSRHFx2OSF60mvEjrBxHgaJ?=
 =?iso-8859-1?Q?ZivVqVU+lc71YUqL/VhvTz+ZDKR0CojfWAi8wntocy4EmcLTGdqGbM9C54?=
 =?iso-8859-1?Q?5Ov4vvKShk91qkH2tddJX8ygAvRczkYGBTg2YL6ElVcpaWgzYavMzgSw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcb81b8-ab91-4185-f4eb-08db0deb168f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 17:52:34.9597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Rzyx/jTYw+AH6UZ1U8ZzwKeMfY6+KocapO2s12jQW9F3KPki/RclfFoKWKFKgOpHaDgdM9hyU4SKF2ltmOBsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR14MB7059
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

those numbers seem implausible.=0A=
=0A=
I just tried my standard quick NFS test on the same file system with sec=3D=
sys and sec=3Dkrb5. It untar's a file with 80,000 files in it, of a size ty=
pical for our users.=0A=
=0A=
krb5: 1:38=0A=
sys: 1:29=0A=
=0A=
I did the test only once. Since the server is in use, it should really be t=
ried multiple times.=0A=
=0A=
krb5i and krb5p have to work on all the contents. I haven't looked at the p=
rotocol details, but krb5 with no suffix should only have to work on header=
s. 3.2 msec increase in latency would be a disaster, which we would certain=
ly have noticed. (Almost all of our NFS activity uses krb5.)=0A=
=0A=
It is particularly implausible that latency would increase by 3.2 msec for =
krb5, 0.6 msec for krb5i and 1.6 for krb5p. krb5 encrypts only security inf=
o. krb5p encrypts everything.  Perhaps they mean 0.32 msec? We'd even notic=
e that, but at least it would be consistent with krb5i and krb5p.=0A=
=0A=
=0A=
=0A=
From: Wang Yugui <wangyugui@e16-tech.com>=0A=
Sent: Sunday, February 12, 2023 1:01 AM=0A=
To: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
Subject: question about the performance impact of sec=3Dkrb5 =0A=
=A0=0A=
Hi,=0A=
=0A=
question about the performance of sec=3Dkrb5.=0A=
=0A=
https://learn.microsoft.com/en-us/azure/azure-netapp-files/performance-impa=
ct-kerberos=0A=
Performance impact of krb5:=0A=
=A0=A0=A0=A0=A0=A0=A0 Average IOPS decreased by 53%=0A=
=A0=A0=A0=A0=A0=A0=A0 Average throughput decreased by 53%=0A=
=A0=A0=A0=A0=A0=A0=A0 Average latency increased by 3.2 ms=0A=
=0A=
and then in 'man 5 nfs'=0A=
sec=3Dkrb5=A0 provides cryptographic proof of a user's identity in each RPC=
 request.=0A=
=0A=
Is there a option of better performance to check krb5 only when mount.nfs4,=
=0A=
not when file acess?=0A=
=0A=
Best Regards=0A=
Wang Yugui (wangyugui@e16-tech.com)=0A=
2023/02/12=0A=
=0A=
