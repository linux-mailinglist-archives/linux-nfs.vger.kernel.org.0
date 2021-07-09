Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28C3C1DB7
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jul 2021 05:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhGIDHq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jul 2021 23:07:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27774 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhGIDHp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Jul 2021 23:07:45 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16930gjw005127;
        Fri, 9 Jul 2021 03:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0/ktg9GhyNP7VClepIpjghPey5CLdgI2s1SaAwHtuA0=;
 b=fOGwTG+AAkbijcw2u3qsLw1gjnd9HqrYlaYGjXqFJ0avpBzCJY58Vu5OtR1RxbmtNsY4
 93wUkh2y66J9yyr58B57ZCBu2X7USc2pBILW9cFV0dj6XJ3RY3D1wIN61leKPHu8+SG/
 6DaIoBdNh8RxAl8iJxb4epC2z2DlJ2l0Mss1TL3kKrbi6WzL8rlAqebETWyLyfGCIGMD
 PpfVE2uOK6DVfizp5wlnuFYZ4Yr3hXnszFKviDNmtE6Pad8nsH6tEqMwshbAQAKRYtxu
 xJtbnS9Y51vemN9tPQBitvnl2YgFXVSCPhp2g098lIl+ptlFv4X0pevo4+3G9UZEHXSM fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39n4yd4f10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 03:04:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1692uECm086082;
        Fri, 9 Jul 2021 03:04:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 39jd17c04s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 03:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOGjTRau5ENSkIunrtrq+oK2cScSz10yXe235XqwGAKFCI+o+cbbRJ6pXy58I+b2YLgx05fUA0HRWH+P2bCivNVZCjFAXzSy0oh55xdgu1roMr+fgWRAAskL3S2zr5PpZvz7Q4UnKqU2/xG8ga3PYQ0AWxQXgLEoCUgc3p/L2iuvROy9VHQ9Idpf2oMbrT6UuO3bh/PkRpgGwl5B3hP+cV6KS/WvTeY5NHCXjFL+iaFDP3spEFRUmn05nz4tpKsdGSwEPR2XQqcQ6HVJHyKV35/bErQWfGIvIlaSnBkp1dtYTq/XjIocyjG+Bm9KsWF1XBNoILhWMl0sJpwONCxO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/ktg9GhyNP7VClepIpjghPey5CLdgI2s1SaAwHtuA0=;
 b=Lg9j1B9VX4AYPoiDOIRcAgZ8SPpypagdT69umetYk2HvpP8CvcFwdQltxVmrO6zOShm1laSjDPeZz2W8gT0nbY2Lc2gKo6YDSeDy9qMmhOqh9eExYpxLrv4sohJidZdN0Ka+uYu710mmDvKomqziWP0iBqndCf+7YCT4Ql2iLGFPUufbxIDZHzuDHOopphstcGzu56yML3mK5xORCwjjqSi7K5iSXLN4JvNnrnw8zlvwErbHQhaX4POmZadKbDoCWd6+3delBRArD8qw9vmi6DbbYEpinfdQBJ8e5uE6UQ2aWE2tVmFVviIG0KpJoamI/uWSiWMGblKa/baiDkhvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/ktg9GhyNP7VClepIpjghPey5CLdgI2s1SaAwHtuA0=;
 b=CGNClaMSRHuQlIrFqZFziq307gwHgJFD5nPA75QxOE/zCt9W+K8vT155ITkJSC8ZqcZZMDcysrDiioDBpo76wdQnU7ehDL9FV4fNPYBRLJTCULxPt6H7CHt+iDZXR9uDshmcaCxOVdhj+sKPkRgfBl2hziPAkS+lkfPg36ZktGs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3669.namprd10.prod.outlook.com (2603:10b6:a03:119::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 9 Jul
 2021 03:04:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 03:04:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3 2/3] SUNRPC: Add svc_rqst_replace_page() API
Thread-Topic: [PATCH v3 2/3] SUNRPC: Add svc_rqst_replace_page() API
Thread-Index: AQHXdA2kVbAtAutPo0KHChRuw3zP16s5uoAAgAA7ugA=
Date:   Fri, 9 Jul 2021 03:04:44 +0000
Message-ID: <958500C2-5570-4B04-9C62-5F971A12D018@oracle.com>
References: <162575623717.2532.8517369487503961860.stgit@klimt.1015granger.net>
 <162575798916.2532.6898942885852856593.stgit@klimt.1015granger.net>
 <YOeKsmTT5L9qjvXN@casper.infradead.org>
In-Reply-To: <YOeKsmTT5L9qjvXN@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39b062de-8833-462d-d383-08d942864dde
x-ms-traffictypediagnostic: BYAPR10MB3669:
x-microsoft-antispam-prvs: <BYAPR10MB36693B7274669F4521C0B68D93189@BYAPR10MB3669.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+MdoRTIJO7sDq7ZkQzsjhu1HpBbT1Fpj+j5vbMa4OImlfPYyLmILmu+1Hc9qXVAlI5ewYajmp0B11EE7/70KWWA2L2EiZ5YfDmixRIox60tiMUBp376DJ4PmizR/EKxyAYuBd4mZFcnE1PKHRbYJaRfO7ZvhzMJ2CDLfSjuQ0iYxE5HGzPOIwGlj+yC4zTZOXaSLnLJFHfOIrWbwRz5CrGYKEo95WTizKAUgNdZC1I1ufZCilJtWxApnnJqUgf9qS9wJTndu0nMedHh1rmO0sL9TAoXba2iXuX42tBFIyYfOsglpyShvZd9i6trDv38igBmwbqzlogj7jKN9IPoR+B4CkNhGmmAQVb4Ywy0fuJZEQWEexuPdsElNpIC+aiLPcKFZaXmvctUf0wMcSCqe9huQmGsK+ndLGaV3/4F09DuTzKSLkqg2qjlt0Cw2QRkESy4cdjHg9nJ2v4uocSTXVSwzsTKrQ611/S5X78cXumxcMTtXOWdLH3W9dQ322XjolUXDlJVVV5HoJglgBcMs1oapFVYa/jJPM+UFkWOHj6rwuiTTNY+Qt3Sbe21fHVx/2w2tkJDYap4RkmEIKUDZg6Hjt5HHqghTWheFiK3xtkBW5aZ5Y06mgX2EBYBRnrLZvWee4sqN4L95r51izcIj8qxXAEv6Kg//wPYLkKmme2IKxFplAxUIZPzHiTRlBw2Fu30AqJU/ibO/6CZjayuEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(39860400002)(366004)(122000001)(76116006)(33656002)(186003)(86362001)(66476007)(64756008)(38100700002)(6916009)(6512007)(6506007)(316002)(91956017)(8676002)(66946007)(71200400001)(66556008)(26005)(5660300002)(478600001)(2616005)(2906002)(54906003)(6486002)(4326008)(36756003)(8936002)(53546011)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UTkQPJJFJ29EDgEgSmLRJl22bnNVPU4moQ8Sd5SseX47pyPwlItD1M3b2kK3?=
 =?us-ascii?Q?DdJ/5U0HEa2wJyORenEijwi/qUR4FPczDKwtTtsZl0W135CMB89n4dKebFGz?=
 =?us-ascii?Q?U8hGDNVazmebhwTdS6Xllj4PJJyeGflUt7tVhvEdHVjWIH3n784ipQXPn3ba?=
 =?us-ascii?Q?XH6O7Uw+JgzRFNOJbJ3Tv3h/pi05te4os2tUMUZiA9nS30XBcBKkP3XvH2Cv?=
 =?us-ascii?Q?AmGQEA4LXI9Dl9UfvUJ/6luHDYD0hDV9PAdxfzDb9NOv/PHDhJK04pybCBB+?=
 =?us-ascii?Q?OWkZlSg1xhMiwjgZuR6PYEvj1XMO7G+LPWc8VWWY4QtOUKHNAIt4EacBywTQ?=
 =?us-ascii?Q?iFDuZM1Nwnr5SpcE0B3KXu/RWCgz83zrC3aQy6ZZvIgCTzG8TK7E12luv/sU?=
 =?us-ascii?Q?qqmnbqsbQAzAQ3MFp6GrtAMGK7UrOBPsskFEwfbAbH837pRIWKlGRaas6vpQ?=
 =?us-ascii?Q?pKaw8n5a72DJc+ogvZ06dtHU+7fkq5mBMRqYWs3d+RWuCxLWg7JxbGzeyCg6?=
 =?us-ascii?Q?Z5BDv/R+4qNswFZqJhfMSSAIs1BYFEmMo7y1wjg+1Y+59/SH6xBpT/Ag3MVl?=
 =?us-ascii?Q?NjlpViK6UEfKWQDqc9Jh1En9RDti7Hvbd43N/RjmrjEtbkmbm2M6M+gR+5iF?=
 =?us-ascii?Q?hVUJubdHEJfdS3pPA8P3QsUDwMDtCs/Jh9be9+0Uzyj4D2BGhGeanMbrLWKj?=
 =?us-ascii?Q?VMz+d1PfyKD/GWS35fMFio49QOwTCq0sxCA4VTmKgpB7NzxPn2ZzIza9qzEm?=
 =?us-ascii?Q?RFPXP9i51SRkgMW7quZ6pK4nEc4/7ZhoCVHNxXCN/ARWorb5/JEBp9JELQIx?=
 =?us-ascii?Q?Mz1UFnk3dZyMd278n9txiO4W1HebQlmkLdLC6veiuGlJAVthgc6NQxed9Dgx?=
 =?us-ascii?Q?jJD3f3gqlErsa5KA9qCJ5gVnEXR9A/0edwigx89JiIlMR7jBU2ugXQ57njA9?=
 =?us-ascii?Q?9kHDsvroauMVwHzFiRA4wE4ICDgqQdXP6ffihPAW6EIcp+6rVl0PhUo85ReH?=
 =?us-ascii?Q?/e7+OBkjo9Lue9yGLzNj6sEccSrkSdaXla6GkjJJ7KcQSbLtRUiSjbgUbrXA?=
 =?us-ascii?Q?zx2nSmaa0gmjsyIuPrCTEbuwTAO6/SCgs+8bB4q941wjLK/CvhPRj3XzrEth?=
 =?us-ascii?Q?Dj5moMF6M3qGl8UqXxkclO4hibV3LtW6YtZ7QHECyuEgWkaYpg4bJxgkz9nQ?=
 =?us-ascii?Q?i9nVivytEzNSYTFpb5EIwxJsOnHysrnBgmlMS96U/eb+cQwyw8aZSkdnUIpe?=
 =?us-ascii?Q?vcu7zC1vyAMrNw78UnQ1DFLB6vdgRHz5uqMaoUlDif2tO33lgzSHFo5IuIix?=
 =?us-ascii?Q?3882e4lGbW56ifjv+CyFpkZL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FA7ED809BCB594995480DDAA1118908@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b062de-8833-462d-d383-08d942864dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 03:04:44.8329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mvn4egXu7insFJyKhyB5a2Gntyy8wmqEKMxfhPmaPbY6Lv8yV+omjfdXQYQtpbh1vBLiTO72HlB5iNPCtmUBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3669
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090011
X-Proofpoint-GUID: Ay1nCuZ-jvClodgLeppLtJCzk5QQWnWy
X-Proofpoint-ORIG-GUID: Ay1nCuZ-jvClodgLeppLtJCzk5QQWnWy
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 8, 2021, at 7:30 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Thu, Jul 08, 2021 at 11:26:29AM -0400, Chuck Lever wrote:
>> @@ -256,6 +256,9 @@ struct svc_rqst {
>> 	struct page *		*rq_next_page; /* next reply page to use */
>> 	struct page *		*rq_page_end;  /* one past the last page */
>>=20
>> +	struct page		*rq_relpages[16];
>> +	int			rq_numrelpages;
>=20
> This is only one struct page away from being a pagevec ... ?
>=20
>> @@ -838,6 +839,33 @@ svc_set_num_threads_sync(struct svc_serv *serv, str=
uct svc_pool *pool, int nrser
>> }
>> EXPORT_SYMBOL_GPL(svc_set_num_threads_sync);
>>=20
>> +static void svc_rqst_release_replaced_pages(struct svc_rqst *rqstp)
>> +{
>> +	release_pages(rqstp->rq_relpages, rqstp->rq_numrelpages);
>> +	rqstp->rq_numrelpages =3D 0;
>=20
> This would be pagevec_release()

 986 void __pagevec_release(struct pagevec *pvec)
 987 {
 988         if (!pvec->percpu_pvec_drained) {
 989                 lru_add_drain();
 990                 pvec->percpu_pvec_drained =3D true;
 991         }
 992         release_pages(pvec->pages, pagevec_count(pvec));
 993         pagevec_reinit(pvec);
 994 }

Pretty much the same under the bonnet. Fair enough!


--
Chuck Lever



