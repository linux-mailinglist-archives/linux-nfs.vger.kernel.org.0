Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40B43FF36
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhJ2PR0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 11:17:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5240 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229679AbhJ2PR0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 11:17:26 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TEL5P8028583;
        Fri, 29 Oct 2021 15:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Cz4z+kGm8tmdxNRkfUQIxxszF2Co7hRbjoNRzN6vUds=;
 b=thPqc95hcCdtNxzP9ffOva/K9ivrTGbHN8sMyAMhrR3Xggk5nFIxJLMxc4f4IpPEJf6g
 tmEfU7NFR9K8WV+Tfyh4FSP8wNhbziLd3m5B8pHz6QP8GeAhUogOsz9FDlHsqnslShoS
 UrelTcbpgdXadJPWRahaV3ie9ZWLT8HxXdDrqT0q5gTLC0VxUt1nQ+y8yGjtrLIw4HlQ
 ognUvQ1K25EyhIiAqLXkDcUfa20lQwL49De6GhS+BkzcSvmnT/wEW6DweZJnrV5umgGp
 HyhfTwY2YPLdg+wPBehm/l+BZSPiwibds/sEcniDmwno+3dSifsDsRYrIyCJ3flsIXm6 fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byhqrg7x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 15:14:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19TFBifY190038;
        Fri, 29 Oct 2021 15:14:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 3bx4gg23g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 15:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joQ9Za3Dln0X0rH6JeA2NUI5SId2UoxHuxcrBkJJ9o0G2IvFI0L1SijCZ6Z0WWWWOh+4DSBptL9p7FZJ25h2h5AdAH2ng6Vli1neap663udTDBdttzUnCs+g+JxhWGQZL+eKzkvJGQrkds0JOe6pQoSV8jSoe4uI4tLAlAkye4NFan3rHJ/fW347nSZCbxBfAy/ggnXUQq+F+3lOFwcqaemZzpPPGPKzVRmS+SbxyNGjLe2YavH6zmkHA+ee2h0U1W0B1qZvnydb9j5K9KHywAJRFQREwB2yQRRYTKdHuVnm/oZ8AgNAaSyFVjcu9y8dIMcdjeXMO4VLwTTMK4i7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz4z+kGm8tmdxNRkfUQIxxszF2Co7hRbjoNRzN6vUds=;
 b=FVfLsePEs7iPllJ7LlprHBiNUg3fLl2CMQ81hz/k0nOqIEakl9WVIwrlrDcvwAJZ8vUXJLIh7n7PSZFKlh7ru9ngCUjJ+jsMeVx7xVas65Dln6YqGevE1CbMUVgH9i1GF8p4mqlxhoKI3lCrd8e6XBL7fPe/L5JrFR3yuKP4lWyDVyB8sM7WaVoJKZvM+B61mXOyCdaS+XonoO+Bt/m8tv7ljqN8JVhHzpGe3nMCWB317K1gLz07mtXakYc8ODcr1ZaVyyCTgFhRNg85AyQhqAu4ng1uzHjaHAL6CLQjBD3ryFq8thWabKOXX8qvnBBaKGFmREUWAYsKBSI+bm6hHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz4z+kGm8tmdxNRkfUQIxxszF2Co7hRbjoNRzN6vUds=;
 b=mWJqfjnRI7gMi5HBHf91dtkKDVTvhMI6LVWhhNvJRfkyunzjFVr/d8Qoz6qBsLYpLD6e76qbThBHJoAap6wy627Ds3vWQotMB94GhZdyb5X5bU6D4AsdbEi8Eys2lzcD5Tm5Smo8UeolkRH35E+tiRDox3bC9bTdmcPau7yW48o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4050.namprd10.prod.outlook.com (2603:10b6:a03:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 15:14:42 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%5]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 15:14:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXYAA6JWAgAADg4CAAANlAIAAA4eAgAAZh4CAABNpAIABnm2AgAX5FgCABmbVAIBtyicAgAA5xwA=
Date:   Fri, 29 Oct 2021 15:14:42 +0000
Message-ID: <2445C26E-7D96-4E77-8079-98B865CC4C57@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>
 <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
 <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <4caff277-8e53-3c75-70c1-8938b2a26933@rothenpieler.org>
 <716B2A38-9705-41D7-969B-665EF90156C7@oracle.com>
 <D55A1FA5-71D4-4D37-9B88-E1733BEDBE47@oracle.com>
 <60273c2e-e946-25fb-68af-975f793e73d2@rothenpieler.org>
In-Reply-To: <60273c2e-e946-25fb-68af-975f793e73d2@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f386e408-df4d-44b1-0967-08d99aeed5a6
x-ms-traffictypediagnostic: BY5PR10MB4050:
x-microsoft-antispam-prvs: <BY5PR10MB40506D7ABB598E9966D08D3293879@BY5PR10MB4050.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4IKi9NuM+qKSGHNDY0LgZZYzAtQp4oJI8fvWQHgszjy5eGx+CvyaVbYg84GBv/QRe+I7ElB4lzruMbUTMLJ+DFsoFBYw8mO0N4TsWdTAnIHyjRg0nNwB0fiMhd3yhE6udl2kL7A1DxkFb0/edbL+E9RPRP3+LjTO68oBX7EcCOUuqQxpPfP/fMz+FIIM1cFsltYfQUKkm9xne8t6C7Hw1TauCOOjvW4ItEZ0463+6Om3FH8Iu/NX6SYCSIrbX5DwrUusvR7EgvI65JeovPcchBJ99tGvXhcWbej23YaeXohRVgF3O3sy8tLaG+0h78JSGv9u4wQ08t+uUhChIoY4BlRPhnLQCSQqlhs+kWu8JidjS2qk4WuaxLJuZazEjt037sNRTQysPM4ytGbawZdlaAIAnCNOKFZ6qPLp8gNZ/8uLBA8yoXcvVEIRebIg0oIxIOpb74OGs1epCmuSIpv9MUcxgUjz0ZI/9veBeLQw1y6UYPfglL+1pC1CpZXynWf0QiMW+7B/8mwffajFGDX0aX9gYS5/UroUYRan0BVhVQnUBoQM/N4BVVid4jKts3p1sfnMxg2eXg4Dy5K+kWsHI0QjaX+Nxi2ix5CDucF57ylRexufz8UZkwN/qrA9Z95HUJ1nYqCPsX24NpLNraz6JgOkG8BxYpaodcHRJnyPUJkKLuNwooxMoNzCjtm9rLrgwApHDhjcWaTj9LFgo3XN09tD/6p8vW9996eDkiGlReg/X/XdR/SYoSTEq9PyGbiHX/yC2rqwATj2EhI6TWbLpsp7e3+BWbJfj50qCvo2rJ6CAqeGrHyCQU+3EUS9XAI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(26005)(6916009)(8676002)(966005)(38100700002)(122000001)(6486002)(107886003)(4326008)(2906002)(316002)(186003)(66476007)(76116006)(6512007)(6506007)(91956017)(508600001)(66946007)(64756008)(53546011)(66446008)(66556008)(8936002)(86362001)(5660300002)(2616005)(36756003)(38070700005)(33656002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JWrLDT8NboLtHoGI5SMwt8vH8PsmEHtRcaFVQPBkWlqjYfozCdXjItt929Gz?=
 =?us-ascii?Q?RXwFNLg/aTQ5U/LyXZJn6Q26qTMZRf4Iiz/lQ0Ot99SJVoiCR0AzamIDyoth?=
 =?us-ascii?Q?XbcVWd3c2LzciY6Bhbnk2ofggCR6H6LlnFhvHjgIhAeu1j8U580X5PQS40y0?=
 =?us-ascii?Q?L1eOGahthA2dmp73v5moRG9vghNNX9zPGx+o8qOGBljwEAsoUondHwAnpALZ?=
 =?us-ascii?Q?/s9gaXx2d/ZYbeiT0+1aRaZY4v9ZoqTf4k+07W2yPDDx9DNoHBl6amLQuppH?=
 =?us-ascii?Q?LwLnN+IirM3ayz4DTQ/ASVM1fNRtACvOX9Gv//TPKMKCB5Er+1gxyUhSvdqN?=
 =?us-ascii?Q?m+1AWTO80e3Z2dbIUT8Cw7c8cR2pl8ktWaHDWCFWQBide2N3u5yOGm7Z3MFT?=
 =?us-ascii?Q?DOOYQff0BvfDDBvQUuG1Iflg3YYO6NVSbXaxjORxii1lol05pW9DVt5zMG5S?=
 =?us-ascii?Q?XhJB/FVKuWRwzZpY4Vdnz2yz0eJScuy6B5GHPhMWDB56A85AgzOeNz5jeaOl?=
 =?us-ascii?Q?1mp4HAlJlxfATmijCptKGTrxIFKaAH5pLGYFzEjSpYbcOnAr2QCF73B4+esP?=
 =?us-ascii?Q?gGz4+TEn+BoNgdJbxI+A3l+lxtAlruAtLUMyVUREPNV4viTN4urEk4nO3YZL?=
 =?us-ascii?Q?+ldyAJQYsHW4gF5NZ+P/KqbTewsf+PYU8MZx2HlwXzddSO/GKJBdqVRoa9zh?=
 =?us-ascii?Q?KTwQ/UPRiRyLrJkvMefq9xVwbr94gTy1cA+9VKfUkXYFAiQNOalyhyR25D8R?=
 =?us-ascii?Q?A85aXuLG6FPD984FzRY4UvHiryJAJt6eNOhRl0OVMzPbXImORTZghF2gVKgL?=
 =?us-ascii?Q?Bb+4fBV8G63HEynkvsL/rMIGM1O2HyjcTLRl/jkI0mgJlGL3gvCkyEVJIiFJ?=
 =?us-ascii?Q?D8GClhDFo7on50QiHotYU2bS4C1EML3XiHooaBw87E6VNQ1Ye6on17IFjqKY?=
 =?us-ascii?Q?WgHgMQ4yHwuGusgG+RHN9kmF1y0Yn9w98vvhV2zmkQc3WnJj56Xj1VFaNZfm?=
 =?us-ascii?Q?0lzr3FSzDQFHk+EC0DYnD57BkM8DVMBfle1VSW+oaYvZu+/KQn+LC5qx3AfY?=
 =?us-ascii?Q?GGO7le56lPvQgRbi/Kg3LyBAz1qZITfpVTpqak1nh1x8aqmmIo0WL7cXySD7?=
 =?us-ascii?Q?ylkUUZbJ/M7QxAwSdqkVPjaqYZLTe3cAanxkDJFr9Xa4zICJwByd2acCnGlG?=
 =?us-ascii?Q?QDsyJYjsLmsd64e2aj+wBoqhit1hR1txyfEZ3Ssk0FLvG5EDIftBFBKdjyyT?=
 =?us-ascii?Q?n38Utm5u5eukn2/GnuGPzi0gZf9xpWaAOZKTe1boRWAAKNi/iERDiDe78AIG?=
 =?us-ascii?Q?f0AM12he+akwk/cTHpafdDAgqcEtwruqB7S/dpte3LRz22WYnqt5TBR5UXyt?=
 =?us-ascii?Q?n2nTTwx1+HjH5xOhjYwIKDzR/9/QRDzvGwMmVDGaHnAQ0pzF0gHHIJUvlJvP?=
 =?us-ascii?Q?99lUSoelGWdTldrFewofO6SE/Za9vyejNgPxdjETKRfjPxddoIy0igaOmUJS?=
 =?us-ascii?Q?tDZ+CkEMyhbaFld/2Z23+G14Ge8fzkmJ3aL8pO7P4Kosh/2oh2im7ZzX20SU?=
 =?us-ascii?Q?kFtyaHzkBQ4IkOb+pRkSPWCV6P5TL2gQvIgjrp7d3lSsLVBtrczPsWXw5aiW?=
 =?us-ascii?Q?Tbu1AWU7PwKFu8RF+JEzmWM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4969C44B77BA024CB52D9C8893C7D1A5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f386e408-df4d-44b1-0967-08d99aeed5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 15:14:42.5534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLm4N1JV+0mAeFP/4SUyKbLi4AhhE2/AY0EY7KR8OLCiMr1jRgqTHkZ5kjDaWGb+8CzWWsrNDUNf9G7rMRZdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4050
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10151 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290087
X-Proofpoint-GUID: -P7lStxsBFvBKMDwFWB0Gsqf4QYI8oar
X-Proofpoint-ORIG-GUID: -P7lStxsBFvBKMDwFWB0Gsqf4QYI8oar
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Timo-

> On Oct 29, 2021, at 7:47 AM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> On 20/08/2021 17:12, Chuck Lever III wrote:
>> OK, I think the issue with this reproducer was resolved
>> completely with 6820bf77864d.
>> I went back and reviewed the traces from when the client got
>> stuck after a long uptime. This looks very different from
>> what we're seeing with 6820bf77864d. It involves CB_PATH_DOWN
>> and BIND_CONN_TO_SESSION, which is a different scenario. Long
>> story short, I don't think we're getting any more value by
>> leaving 6820bf77864d reverted.
>> Can you re-apply that commit on your server, and then when
>> the client hangs again, please capture with:
>> # trace-cmd record -e nfsd -e sunrpc -e rpcrdma
>> I'd like to see why the client's BIND_CONN_TO_SESSION fails
>> to repair the backchannel session.
>=20
> Happened again today, after a long time of no issues.
> Still on 5.12.19, since the system did not have a chance for a bigger mai=
ntenance window yet.
>=20
> Attached are traces from both client and server, while the client is tryi=
ng to do the usual xfs_io copy_range.
> The system also has a bunch of other users and nodes working on it at thi=
s time, so there's a good chance for unrelated noise in the traces.
>=20
> The affected client is 10.110.10.251.
> Other clients are working just fine, it's only this one client that's aff=
ected.
>=20
> There was also quite a bit of heavy IO work going on on the Cluster, whic=
h I think coincides with the last couple times this happened as well.<nfstr=
ace.tar.xz>

Thanks for the report. We believe this issue has been addressed in v5.15-rc=
:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D02579b2ff8b0becfb51d85a975908ac4ab15fba8


--
Chuck Lever



