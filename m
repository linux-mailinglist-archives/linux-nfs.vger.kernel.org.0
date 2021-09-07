Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57190402B21
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245148AbhIGOzW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Sep 2021 10:55:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18172 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235774AbhIGOzV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Sep 2021 10:55:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EhcPL008782;
        Tue, 7 Sep 2021 14:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dzh03Jy441mHCyS4j2KlKsUGqZpVQB7LWt6Z1eckrKI=;
 b=0BpFUI8vuWZP9QhqgNc/0zLzj11M8fP5GXPPshpjlk3KtB9fulrv+M6FtQBkOCjKELbc
 R64eQ/uWjlrdlhInYHJXv4moGof2jKrxxROavoELaEMuvdzGJfvFR/YRHstTNTBarPus
 ioGA6cQ9XxRDbmzZsj+CbZ0NO85QFy0AldyrZ7NDrnr9e5EQE+bs9U79hv/XoLe/QxTh
 bo6f0y7Q1W2i88IA7T3GOesDzJ94I7XNbJYJA6SvXMmUQMw5S8DaSqdAKeDKj6V0rdYf
 XOM9qC29Bidg+L3odZxqtX3haSu+/ENd4uYn+nXuP/pqV2j0AeJL9xFf6oFLLu6TwCme qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dzh03Jy441mHCyS4j2KlKsUGqZpVQB7LWt6Z1eckrKI=;
 b=Q8cqkR1hkbf1uH0YuNDvp+2nCVRwm/EEShuPXDvGbT6cuoYuVAZ5C0vQFyOiu/F7zUmz
 mSgCLEcWTJQmtvMnMtZ4+o4b0gcXZsuFBvBpLwtDQgZN31mSe7kGX73Gsdz9Wq0y078y
 mGCXL8RW1OEjvJV1RhDe0mMgQZCvwvXfuapoaUgcUg/DvZy+0fKafGlPq4IlZ6d6Ov5b
 xPKTM0SRM6Q18owa+P972uAAhpI0AERiRwPgmUVLBzNllT8xGcdVnP13utlk4PGZskPK
 wxQg/2ciyBWZtc/4pU7iW8hlR7U7qQcDQHqF0chbcLjFdDIs3qj9RGrSV5UHh47WEyX6 Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awpwkt75k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 14:53:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187EomQe053243;
        Tue, 7 Sep 2021 14:53:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3auwwx0my0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 14:53:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3NQSFlKLubg0gPY5bs0JL+vUz3nvHcGcOT1L8Je8QAO7/Y4mT9IEQ6fe7KNmPFcqaOEsH/xhrhL1U3DGPm6p9zul5eyW/w7ix/Xso4vsbjUBXngzpwnstCC8hrHSU28BtyrljSBO+WZncc9ebRkA40Bp59FFpau63eTjghuhBJEdq07PPfuOMWqZnwABULJ69yy415XfBmDBhekf2sYeN+kAhN9Hmt4V7Wl4X66zCoxf3ufB0Jz4w8uPu1w82/yEdPqBeADJF5lNZghFaQC2A1/orfZlRJLvrG/ZBHoD7wP6KNRLTisMz/h9HeA1y1sCIxSy2XOmrvVEEtBU2tyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzh03Jy441mHCyS4j2KlKsUGqZpVQB7LWt6Z1eckrKI=;
 b=Y7rDFR+jrE4o0LO6JBxcSVdAW14CwPWwvz/8Nn46oft1BIOWYph1F/FkWv3SLdjbUCtyUQfw3G1mf9mEQOK+//1kIkWmdNE+AwBbmZvbD/XhP+D6P+4o+wCzvsyHnlMAKmKLtRVxsVXIS5MC3KoIkPxhSFpGYt4WmHgHQGbbOe2m4o3lycihMJep96Qs2VlvhglD6mVnOLkpJcuaPA1SyzmBM8FD+AUB84aPr1FWgTdSBGgIUkFMzkezOz99RVws6k+A0CP9x2imAK2ES2bftnLyR3zCo3k3JNt6y1ysNOQ++CJ+kFLhamjJyUacp/W8oMmuOYiMi+6gWVPdZzXlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzh03Jy441mHCyS4j2KlKsUGqZpVQB7LWt6Z1eckrKI=;
 b=osf1apv0ibnkqGqUUDmCqZ8KCk4jvwiAKcms65ui/zljcIGAM0mhm8F6a++dfpsQxo6JcOXuoSMntql0Jb2FMwv4FI4vtt5RC8WGSOZMM8tnd1IP8cfedJH0CkAforkKvlqebnAn2nv0rRgNpffM9Ede6UFrv7pIYQ+Iaf2nbaw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2517.namprd10.prod.outlook.com (2603:10b6:a02:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 7 Sep
 2021 14:53:48 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 14:53:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Mel Gorman <mgorman@suse.com>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Thread-Topic: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Thread-Index: AQHXotncpaMymYUO4UWd0a8FIk5gVauXJwiAgABMkICAACIbgIAAJs+AgADuHIA=
Date:   Tue, 7 Sep 2021 14:53:48 +0000
Message-ID: <8ED6E493-21A6-46BC-810A-D9DA42996979@oracle.com>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
 <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
 <163096695999.2518.10383290668057550257@noble.neil.brown.name>
 <163097529362.2518.16697605173806213577@noble.neil.brown.name>
In-Reply-To: <163097529362.2518.16697605173806213577@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85b08986-b70b-4f76-8e76-08d9720f4c7c
x-ms-traffictypediagnostic: BYAPR10MB2517:
x-microsoft-antispam-prvs: <BYAPR10MB251788C1608AA51EF08D954993D39@BYAPR10MB2517.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /tBgyhA8yNtZHhEmBWlb6E4zC6I9wu+TW2f8MBRFhUfBwjPgb24Ug0s+2CT2aKhJ0K17cs/+WA5F5uKveAdHRwbt644mx8w3F3zbNTy9zaqIWHBlRZVD2e3oQSC2MyjSl0UjdLNoDRpHnAkvaGK60iLCpBKDLs1Wfu2KTt/o0b7k7b98vXXg4Jg4+WHcm3nA4tGFSRjmSqnT0eY9gDApzVrjrG5Y4FV078yZy962cmwWlb77gsrnDzrqYefZ38rSJVQnNWDs555bAVARY26PBzo5vDA7hGVgKPIyk9/V9ojcQ8kkFlpxe7toiVbkn/Rf/b4rqTSHCxETnMqGU4iMZS7TY7gdkBrp6+3r+Bz37OWr1P1/o+M8RL95kAgXpBQ3Lh3vs1wvexCsem0muZO3zD2ea1tYn8GraKfVjH2mPtta4IGPnJcWTEHPxQgOw/vh4ymEls5cYmj+FzXGodvSz+1FURmPdFAFBVP5S6IXoYLKFMex0YboJsv77h5svH2p8An0hPurBzNmoOF0XTvigHxDMOjGl6LaFw8QEgLmdIQa8t555hHS55gW3zOZ0S/H3koIMeUJt5ShUxlVPMFFkbYQ1WblmRVA7deVwKrTm3xCXucEyoz/q4t7kbmGzjVNFK5QEg9uw7pDX00NCL30BtE+ChWnzrDV9ZevuMFURedNdVs9vXbNGFiZPsQOkknPoY/KcC5SZ1cbLJF+/vBTha0CUhoecwjq13E5AIOJzJNLwQIFvusdtOD79NYOff0O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(136003)(396003)(376002)(66946007)(6512007)(186003)(66476007)(26005)(66556008)(6486002)(2616005)(86362001)(53546011)(33656002)(6506007)(54906003)(66446008)(6916009)(36756003)(83380400001)(8936002)(38070700005)(2906002)(8676002)(316002)(5660300002)(38100700002)(91956017)(4326008)(71200400001)(76116006)(478600001)(64756008)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BBLzxQSndb5TJ2I9yIYSRSS+9Ok2amdM0TrLm9J2IW4IOjEITN+CFzYMRDc0?=
 =?us-ascii?Q?tK+Kc5AMuiRqOcWabkzyCkq/5xyYF1REwckSDvImhY1wJwoxIPFgzzg1ds1x?=
 =?us-ascii?Q?6VMTC9WGwEGg4fwXU/I6233tcF0WrlqDoViXf1uFREd/XX2sKlAyUr2kftFF?=
 =?us-ascii?Q?+zNLKJU7zdc/GTOYB62yLLHiDhasK6VHVsIdlPvUIm+a5rVxCL6rpyBaUAW5?=
 =?us-ascii?Q?dEvcK/IYOlAht/dbW339GGQavT+5uu8kM3Sw0jznlDbZ+iRyVAK0QgVWxvsC?=
 =?us-ascii?Q?U3OgwBYvo1kx9IP3mvm2Ad39C1xZuFbJIhzpAUD69V5ARNRTbNYWZ98WMuFj?=
 =?us-ascii?Q?XZg0bFP+Q4tkfS+kZmeaxs3HAVk059CJbQx0b7I8SKMTMz9d5cCXED0HnaCj?=
 =?us-ascii?Q?3yJ4iRFxNcFQoUZKCDZs8MuikCss09XIpXf/30eRuzfXpgcAvXvfgg7vzt5l?=
 =?us-ascii?Q?WwfnLb+vNk6QwTopgHO6ee3Vyzmbw0wcyYs2b7f++lstsBht+aXrkqKGA8HG?=
 =?us-ascii?Q?nm3BA8mXx3e4c5vkyV1cKm22o3Vju3doeqD4mmAjFV4g7ldFJh1HBxxZzmHO?=
 =?us-ascii?Q?OKPBAtK2VAobOyiX2vNoLP7TYEfmZMl00/BW0lMtOyEPRJ5PL912g6pMutgW?=
 =?us-ascii?Q?9Tsp402l3fA3Or3ZwK39xsdZaxSBuJmKieckSi5Fzz7r8L0Kk+WARe1u4u42?=
 =?us-ascii?Q?W2ovHNvQvP6/2R+d/5HzxG/P55LYx/XDj+pAiDjtGNX/VqpKPOnFuXJGLpBp?=
 =?us-ascii?Q?oqeSgqiQJksBrVw9UXnJGLjipQ+38k3mZNAuwyAIfcNOM3+YL72mp4XhwgU4?=
 =?us-ascii?Q?DYobF0AtXwqnylXKN61vOamAK5k5hsG9uPkigMNIrkw7ZFVPcUoJVJBOErnc?=
 =?us-ascii?Q?HrLnOTedelNiRA3POgZvekQ8HnycaFS8AOuyMpGwUXlm+4TWxcwJ+80bSFF7?=
 =?us-ascii?Q?lpffh8buJB1OL8+vrMJksYpeVNvQRfAHrnJoAAL2R79oY1/ejBBt72QrlPMg?=
 =?us-ascii?Q?A+aX+DzfPrzHm4PJADrXe3GL1Rz/CeJdlNwGc8FtS466KtaH1pfc8Fn12CqG?=
 =?us-ascii?Q?GlLrDeY8rrlIx+CtS7lUICS1s0Ip18/Yx4sxRKeHFs5txhhW4fSblD9ImU1x?=
 =?us-ascii?Q?5m5aqV42Wjod092uNY9jJ2PYhl4NQ37RRmhqpzRMTit1Kaa+fmvH71wqCAi5?=
 =?us-ascii?Q?c+zoDf444H4qiVaOsHO5tIlGWcW574/ZDlyig7eM3JRnUcAqPZs8Y4vrDgbI?=
 =?us-ascii?Q?dUEKX7f/1x2w0tYFOB6o1aQBeNi4f6zSNz6kYxgt9AL5sSF1YRpxmdFCnBZn?=
 =?us-ascii?Q?NbFg+2m2ubS7Voq708AiReNW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <317DD58F770FDF438DAF2944A8BF9F16@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b08986-b70b-4f76-8e76-08d9720f4c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 14:53:48.1220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ad7yLcfCeuwijjxISlodo+aFKifCw/UwlPJmxylIAKe3qr2LVzaktTYFLWrvp5gnSuVm0KZe0uJcGI3NmXSjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2517
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=795
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070097
X-Proofpoint-GUID: vz4stba9vGKahjEvuK2RVYmmYXy1kHzw
X-Proofpoint-ORIG-GUID: vz4stba9vGKahjEvuK2RVYmmYXy1kHzw
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2021, at 8:41 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> When does a single-page GFP_KERNEL allocation fail?  Ever?
>=20
> I know that if I add __GFP_NOFAIL then it won't fail and that is
> preferred to looping.
> I know that if I add __GFP_RETRY_MAILFAIL (or others) then it might
> fail.
> But that is the semantics for a plain GFP_KERNEL ??
>=20
> I recall a suggestion one that it would only fail if the process was
> being killed by the oom killer.  That seems reasonable and would suggest
> that retrying is really bad.  Is that true?
>=20
> For svc_alloc_args(), it might be better to fail and have the calling
> server thread exit.  This would need to be combined with dynamic
> thread-count management so that when a request arrived, a new thread
> might be started.

I don't immediately see a benefit to killing server threads
during periods of memory exhaustion, but sometimes I lack
imagination.


> So maybe we really don't want reclaim_progress_wait(), and all current
> callers of congestion_wait() which are just waiting for allocation to
> succeed should be either change to use __GFP_NOFAIL, or to handle
> failure.

I had completely forgotten about GFP_NOFAIL. That seems like the
preferred answer, as it avoids an arbitrary time-based wait for
a memory resource. (And maybe svc_rqst_alloc() should also get
the NOFAIL treatment?).

The question in my mind is how the new alloc_pages_bulk() will
behave when passed NOFAIL. I would expect that NOFAIL would simply
guarantee that at least one page is allocated on every call.


--
Chuck Lever



