Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E33B6978
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 22:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhF1UJQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 16:09:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43654 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237250AbhF1UJG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 16:09:06 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SJqWfm021047;
        Mon, 28 Jun 2021 20:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4CgFPzIAcxHTNdaGYPcXVQnun3AeBP9RBrHqotG2e1Y=;
 b=G/elS4mHFsGD5nS2PmXe5bL9IkqybL986WJYSxNfhWfmSlTIQBrvuFFoyGyHAOFxv/d+
 G4iu9FHKwnV+3eggpUMLvNpUHibTscKGGfJmUIAJeE91EbGgFx0SGJIRScAookiwPnPf
 BOlbt5RTlR2s2bX3GjzzR8M5tOpS/013BJjkzsAKvj+IIdDjwF5O66WnKfpeRbrDVv4Q
 s58NOkoM+ydjO8uRwxvRORqYUY9e71a3qs+0aXmrfacPfgnnr4bLCER0hSNpihdp0Hmv
 Pem2bwLi9G6HuUq6b+C2sHMfJQsii8MTf6JsEfgXyHDAZUn6lKIgJOdbU5crfK6QerZl 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f174j4n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 20:06:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15SJncNE086379;
        Mon, 28 Jun 2021 20:06:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 39dsbw2ur6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 20:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk4stCdT1UnmJJ2A8jNxvlddLakzr2HKkalKVSSSIUvn4Eo/cFrdYbxgY5eYPPNWZVhYM3Qv4ebCVFDqwFBP9BJ/UXZp2cyPLoQHDH/OIeKKrbW0SBVs6X4goYmmfLemvzj6Wo35VvGL9ENmKD+S12/IACH5Z4Dj7pMgwqR2s0g0xzl5E55Z5YTW8YODBPWcGtE3/TnVUzqC+JyhuuHo6SpYtiH2LXkaqrp8/TXe8VfhLJDKZGEVukvcm5kw9XkGqeGukU+T29U+ljJp0ZN6ZU2f1tmcf3cpZy1DBMg9YcFvnF6HfW2pVkDDMQPhxl6sQYMJbaEFFuW0u9XVa3Vjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CgFPzIAcxHTNdaGYPcXVQnun3AeBP9RBrHqotG2e1Y=;
 b=jADKRTCfstklT5vzDf1vLMM7mff2trLkaeZ5tKFn124aZlWTTaydKoIkiXvcOWDRaqzVGTclIGS+TErmzX9l/WLbTOKqg5t2zoTWhaND3CCL+UcKTml6fM1MNdFXCIjmYnTjtwdg+etcBktXB0THT0V1SFc9MiIAyXFRhNPJuwB2b62zo0ydyudFnnZkW1HWMQ/FSutgczgSJj5vSqEzq0zG8pPafznkc8nwEKjDVMUn3mtP/T4WgQEk2cCvEj9DAJ3guYQzruZL4prSydqdfRELo+7h7108zzEObI5Cj+318eHZM0Dhs0i1IEz6cY33oJhIDQHzESw5qL1kc3IhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CgFPzIAcxHTNdaGYPcXVQnun3AeBP9RBrHqotG2e1Y=;
 b=WayUqDMowJZW+14VeH6MvOrGAJyV7dPWyzsDz+nFMDaqeergPlMJosxjUwvwsKPqy+QiQTJGl2mZwfxc3JLvm0hd1cY5cjwBvCYMfhAmaw8udvvUoq1WBWazrg2nTgfVNabjKJJYMuk5Uks8O7ovgLZJnbyJoJVAgx0NMT9CZZU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3334.namprd10.prod.outlook.com (2603:10b6:a03:15b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 20:06:14 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 20:06:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: Return nr_populated when the array is
 full
Thread-Topic: [PATCH v2] mm/page_alloc: Return nr_populated when the array is
 full
Thread-Index: AQHXbEk9yDQZ6HKQmkaxhFFIsh+yuaspuxuAgAAeaYA=
Date:   Mon, 28 Jun 2021 20:06:14 +0000
Message-ID: <CBF7F352-B955-45B2-89B1-C14AE2B2FB54@oracle.com>
References: <162490397938.1485.7782934829743772831.stgit@klimt.1015granger.net>
 <YNoSM1A/tS4SEMHE@casper.infradead.org>
In-Reply-To: <YNoSM1A/tS4SEMHE@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66f457db-092b-4e3d-9bd2-08d93a702eae
x-ms-traffictypediagnostic: BYAPR10MB3334:
x-microsoft-antispam-prvs: <BYAPR10MB3334ED772372664D41F24E8693039@BYAPR10MB3334.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCXRZ5lvhE3N41SWwXywjtglG7KpLZHhAP7bqAgO/7bXZP+T4lg7MwA/o6eJbl0eJmnGkaVnMcfXJsftT8YbpoPJWwH7/TdnNy8xEtnc3wLJBE3ATIjwWZU+ZsErPBkw4ytt9zj7b7aAUC7fvd0wMXzA0dIxX4vCrv0DZs7pziDXFmYIPmqxFbW3uh65Sc+gfAXxR+LuUIKATpQ6Tamm3mOTbKVRSg28lHn+kwQkTNZcN7tQJERvBbfaSqiXL7MZYJetqxh7d201U4Norl7oBloALkArHe3JTcVOjfhdRd0JCqorujNVFfn0Fj+56bvSt9mpfQe4nJe2q5rYHVJ2AL3gMcbK8pezGjdHziV4mWb5bRYEShqFL65cn7s5jglJnhUxxZruokq6Kzj0y/YEkzT9i+ZqYdx3bhKcWJIaiBIzLsFA4pgS74vPSGvKz+A40HoEVUObJl5AVkAAreLx9pJUkSJqseDYP93uMANVRP9A+5nDoihREDdkXRhGL1SCmi2H2oeQvQBplbvKTW/VZPDVPqkxGzPzUkAQ2HIbw55/Qzfd0hrbj1Z5z1KTRSpNVDfenE8KarRaJI6A+193Evj8d+GmJPjJxt+Ct1qbrXmniX8H9v1ErpctLiSE3+yIo85xfnDs7yVyoed5DWCpy3iJvJzGO8ij68sG0WFx8kz+YZ5QhG0H484/CMhUYbh8+Tjr5tpo/g2GUv+ufCZxTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(346002)(366004)(33656002)(316002)(36756003)(2616005)(4326008)(54906003)(6486002)(6916009)(8676002)(478600001)(6512007)(38100700002)(86362001)(5660300002)(122000001)(2906002)(64756008)(66446008)(186003)(91956017)(76116006)(66946007)(66476007)(66556008)(26005)(6506007)(53546011)(71200400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wt+mg/23doPZHswQhSAptApe/fNYRGLtRghAl/2PvknvWvFnwUpPsRTSAtQf?=
 =?us-ascii?Q?I43j15fXCP0AtOZKcLBGg9BITBdjl3CABnLoYnbURKc/hWuZ+/nayfSVTiVH?=
 =?us-ascii?Q?+T67+qy5yRsJHR9oB87vzSHxEJyASOp5GHKaGsOzddt1CZvY4RfX+4WmqEdY?=
 =?us-ascii?Q?WfcCwozOuREnR9Jw3r3LLVTXpRwRIjRMth9fEqsaoqRnZuU7E1BKcJXMQTw0?=
 =?us-ascii?Q?kQpjSAXsN2dtjVjcQqX1WdUvTBRrR2cq3ZhcHDj3AoKUXyMfs3DK1xWI8b8a?=
 =?us-ascii?Q?t+FMXpoJ1JdiIL/ioDV4Y7TgWh1R0Cs2noFCrg/Yp2HpmYqy2xeojJnqt1AY?=
 =?us-ascii?Q?n1YmHwMD2K/5SBrxJbMmV42GmMOicv/ZbVlwSXgpNaS8Y9NpgXgJlJsqVUyp?=
 =?us-ascii?Q?Syv+eA7CwbgcPXDd4PWxzLzDzNrOjvwxEsqBi+kK4wNfrnbC9G2OL3CKR0qB?=
 =?us-ascii?Q?QfS0b9LKSirlOOwbSbCGEbwTGgrA49dE/QfTRcJEuxOFrugWXtjttTyhXL/Z?=
 =?us-ascii?Q?3Z6wLp/jmTgKOlgYhrywuAclC7zV/wBTpBBi0bXUedTNi4D8yjYvQzQ3ROh4?=
 =?us-ascii?Q?3jKrTF8UB8BBciYBhrtlcZFKsn5frq6yTQW1EtHdlvs3LDRXparLZPf+cf6t?=
 =?us-ascii?Q?2HznnpSc7R+xS/yrDrQBf1Gzc0AHNzc+CT4AVge4tFhoYSwxbJLYDGehHqXj?=
 =?us-ascii?Q?Fhug3/7FY1wXqhutSp0qknzB4FJMzTS2cFCJsPgcm+UI2OyCKPWsoENv9Arf?=
 =?us-ascii?Q?ifdevEkcDhKuEjM46g+ZJhukAJ/IIQmX4lmzbkQbIBho3IFFTeeQwK3rpn3c?=
 =?us-ascii?Q?3ABM98TpdX09gVKsG2FpoqdMVnz4iKvoO+/w6IFWca3g9qQ+l78nmtMFjWGr?=
 =?us-ascii?Q?Q5HJsC3x94OWVLU9s+QqSeTKrQTRCsWMz2nW99Mz0VamK39Gm1ha7g/qMAt8?=
 =?us-ascii?Q?fS+I5aRo4Ctucrau/AC2z1Q7wftjORFxcCtFlv6w4PhEw2OxDlAEHN7ZSjSj?=
 =?us-ascii?Q?cJx+Y5Nn/9VwsiVnm6dttpPnjrK1rNkKRNIvomiaGYldumBKH6e9YTGow7Au?=
 =?us-ascii?Q?MtWVZAzDAJOlZoVMhy/9Qym58sDfEFgpYf4SWz/xruYYGGvsmcgx0KES7PGc?=
 =?us-ascii?Q?QoDFJWEvtEwJMLIw3vAqWKhmn0rbDlPRQFl8aQxSqfjbmZJ3PMkI+c4pePia?=
 =?us-ascii?Q?zGpiyoGlr+7WyGFA96LVNo0daQ5DZTeCkXe8hQw7TIpeoVooDXlY+V3DSauU?=
 =?us-ascii?Q?wu3GIYzg7iw0sTKGSWmWzrxdoXspiYhzEkF6BVYj8jIah+gqXblgiNxFcFZJ?=
 =?us-ascii?Q?Kb3Buefp0Vi7GNE2auSFJ8kp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <273CB8479A6DE140A9BE25807AF8D762@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f457db-092b-4e3d-9bd2-08d93a702eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 20:06:14.3111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6F14LT07uSQZWOcpFlQm4zUaIlYf/Utf96xwD252uoGgLvtNwwZo7yMGU/WjZZTeoy5B8PDSaYIL18oRdIe+5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3334
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10029 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280129
X-Proofpoint-GUID: xqYJBbtB2IfxsHuSLBfNst7mAevv3Iz3
X-Proofpoint-ORIG-GUID: xqYJBbtB2IfxsHuSLBfNst7mAevv3Iz3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Jun 28, 2021, at 2:17 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Mon, Jun 28, 2021 at 02:12:59PM -0400, Chuck Lever wrote:
>> The SUNRPC consumer of __alloc_bulk_pages() legitimately calls it
>> with a full array sometimes. In that case, the correct return code,
>> according to the API contract, is to return the number of pages
>> already in the array/list.
>>=20
>> Let's clean up the return logic to make it clear that the returned
>> value is always the total number of pages in the array/list, not the
>> number of pages that were allocated during this call.
>=20
> This is more complicated than either v1 or the version that Mel sent
> earlier today.  Is it worth it?

Yes.

My v2 addresses the reason the bug was introduced in the first place: The
code currently does not reflect the API contract described in the documenti=
ng
comment.

A human reading the function as it is currently written might easily expect
that a zero return code is proper if something failed. However, the API
contract does not list zero as a unique return value with a special meaning=
.
The contract merely states: "Returns the number of pages on the list or
array." Therefore zero is a plausible return value only if @nr_pages is
zero or less.

Note that the value returned if prepare_alloc_pages() fails is also incorre=
ct,
by my reading, and my v2 addresses that.

The only other call site is __page_pool_alloc_pages_slow(), and that looks
incorrect to me -- it does not agree with either the API contract or the
SUNRPC call site. I did not fix that, but I think it should be looked into
by someone familiar with that code.

I haven't seen the patch Mel sent earlier today. I was not cc'd on that one
or on b3b64ebd3822.

--
Chuck Lever



