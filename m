Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C04307A1E
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 16:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhA1P41 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 10:56:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52636 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhA1P40 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 10:56:26 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SFtZBO080885;
        Thu, 28 Jan 2021 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8+/j2SrmWtcnAbZbBg9XOJOCytUVSAd2TJ9oA43LjD4=;
 b=ZYW07A0d6fAiX89n6UynsHOcIq0cqVgcj1nQ9lNO1KdEB38/tELNPwXt1siVUzKbf+kG
 hVNZztHTVwvgIW/fyXDPf5tLJEzH8QsfzV+iyRprBihBDBryWkiDye+AmNbyM2hC1cLb
 URMRvMCdnaZiTjB7ZHBsYbyCoIXdu7008mc9lvtLE4om/dVVHnerpyXt7EppaH5ihIJg
 RnGywUEddjhi8Jbj8oXoIhpVo6xhQAkEbXy8LaQSCaRBx+75ODKcWBLVOppR3qTeTWIM
 lZlCh1Y6Na8+9f/CD/jqbi0H1k8j/qUEFujF1Ai1EQLRvZbwnzAcQ8pmyedklY8E0Fz5 gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 3689aaw09a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 15:55:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SFkLSr047619;
        Thu, 28 Jan 2021 15:53:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 368wju88ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 15:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuYD9QX7WlSEIRlV82MQ9sRJ3ebTIi84uuMB5Mnt97eYXTVWa1tdWxNVGMU0cx7X6Mx9Y0vkYG7YU3ngIFDIziAWldb1EKx3WAgeAiH41EDMj2mbB29d/XQ3h1eRpvAz4qPr3mQY/ehUJg62nq/37Evq3RskwmkwVnGBCFVfS0CCrrK2KS0ateK2nmzAm7GoevAlCEIo+/eYANqnT0WBwvFhNjsgkI3mA2K510GwIMFwlldPtFzDGAaVftWy4fPzCmqahysHrAwn4nAbnOz5VhqkOpDMl6UMWkRLZBTYC4/MXcGAiJuxlEGyzaiYtAu6PZB4j9H38OhehY2Osdhw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+/j2SrmWtcnAbZbBg9XOJOCytUVSAd2TJ9oA43LjD4=;
 b=A5CgTfJUbaauzzhDfxSJwKfuS1XqHjXK3+cINsqh4ADv501wphOdCYvHIG0JwHa/4vu6tAovTNtPmm7XrRbM/siO3YOiACc8Zvkoocd5QFGRN4Y7wjyfFio1jrlQFshblRme5aqm4C0oz55VJxJtQ5skH/Fc22mI6qSWsc6HwOyS8CNZykvlMkH2RwhPaZnV++yDDaDi0jjNYFixA46oRsCZBcGU3xKbhvyevwzRbeCRNdk7rnOYITyh2NCynSSEVIAzI1MGHRkWGVd2v0eq7KdQ2f22bm4yvN6XIWYpCX+11tPVRKVyfq9XxRuKtw41pVH1P63WueGJW3f7jeyEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+/j2SrmWtcnAbZbBg9XOJOCytUVSAd2TJ9oA43LjD4=;
 b=BVdFjE7GqzBInevbJD9b0elMX3fkV1UlKFs/5k4slcVm/gOHjj7KB0IToNfV4d1zUMZ1Yz8hREjTXm9PeOvJZV4QHdk6kOnx++sEyl4T3PoYBbasjyQp2UOOp6dVgGpllJObef6b+PUSASaOkntOYUjhF6egJiTnObQXvl1TU7I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 15:53:37 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 15:53:36 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Colin King <colin.king@canonical.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nfsd: fix check of statid returned from call to
 find_stateid_by_type
Thread-Topic: [PATCH][next] nfsd: fix check of statid returned from call to
 find_stateid_by_type
Thread-Index: AQHW9YTPCLLIIxyNd0a0oDXS4LB/Gao9IuIAgAAIVgCAAAU2gA==
Date:   Thu, 28 Jan 2021 15:53:36 +0000
Message-ID: <80ACEDFA-B496-44E0-AABB-BD4A7826516B@oracle.com>
References: <20210128144935.640026-1-colin.king@canonical.com>
 <793C88A3-B117-4138-B74A-845E0BD383C9@oracle.com>
 <20210128153456.GI2696@kadam>
In-Reply-To: <20210128153456.GI2696@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18f7d29a-c985-4a25-678c-08d8c3a4dfa3
x-ms-traffictypediagnostic: SJ0PR10MB4494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB44943B6243623146018C8F8793BA9@SJ0PR10MB4494.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNbeppzMDG2HSJOAdlHLEzvpfGfONDSM4dd3ZYUmEEE7K4xNNMKfRu/VL1dFVs7KmYzdZ0sZNqiIcrzkZdLGnCHklG20JyYbCvyFKXuNi1Qza10/DInEeXkbiJIBhPIyaUCDMy+62n4FlQcr/ojrQaMq8rNF1tO2Q0rAFKtN2o+aMviO6BhOorVL18gfbCkW5LL61N96fWvzRY6+nFTpxAzTkqdSwPMwuFKyWOc5UmXFPDeZkPdAg4wt7XnFhss+6jniWfPZFSqxjxZ3ZHvwixXFLcyMD/OWhDnzcYomqdBGJm2q/jrF6yFh8sLimdIYlhaJ+5hzP0Sey0wHLMtKlg4U6vGtCkE86eAi8kHpZKCz0MY1eCihLQ4zRA3eZiWk60dEf/L37Fh1mM68OW64oMcHWdnZg0UO9WqSnXwaSdoLevcBeasc62U65LHBWcjtEvP+zFiaj6rrz3Pi9FejnWb0sVw8Xkd1OIhaVZJZgvQG45CtjuptOHZ+FSexi4LMVeJfTAttaKWLnUOOZgDg4fO40+XTIV+jw9D9U4RFikFPRLxB+eT1HVKSH9VgpSXOB5E/QRYRZ4sow1dkq3zI89eqebj5VHplNLwKukMKKG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(376002)(346002)(4326008)(36756003)(6506007)(6862004)(6636002)(71200400001)(64756008)(26005)(186003)(86362001)(6486002)(33656002)(76116006)(8936002)(91956017)(2906002)(5660300002)(53546011)(54906003)(316002)(37006003)(66476007)(66946007)(8676002)(478600001)(66446008)(44832011)(2616005)(6512007)(66556008)(37363001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XSp/ZA/+IatI0EEG3BZHM9PPL6Aa2tdpqTzNQxJgN16iSPo22QY1lIWxVv4D?=
 =?us-ascii?Q?58Z/afQPqdCH4VIZG2Z6dU7a+TAnTtENhCdH7bcsLfTwTsSS8AXlNvhq/zgq?=
 =?us-ascii?Q?/ULJagU7EjD8L+SpXl4uhv6Gmd0/E7PXqchAjtP7Lax+7Q6ZlbDChqQuBsK3?=
 =?us-ascii?Q?QuDVcC/nYsbYdwo2szJdyNyP5Ob6+PyqVXGwD1p/zMFC2wRrKXWaSEtyw6ud?=
 =?us-ascii?Q?7WMMYxjVofH1wWe3p9jRAHnxsnkWV9CqQ13ys7qNpNG4VTfKn0xErc7XGSow?=
 =?us-ascii?Q?q8rv9WUP98yOBlGsEIJRy/Ii5v0chBCpwp4PhAqC0YtiiQSZjDG2lIIv1Y5K?=
 =?us-ascii?Q?J2x7t8pvU8XJWz9blpnO9Tp99pnoQ35fpv8yBX/xiNx+tldF/AD1im8EF8AC?=
 =?us-ascii?Q?90iX+zlZClIfKfDKsTU2F1V5LJ9hTSpi9YGcRJfXdWVFw74CgIL6+YXVjE8l?=
 =?us-ascii?Q?LJNf3ZhWQeB4cnv5nTtQUGi5Ll3jUJ2hZfUFEFlCkU1TMasp9dFUWfIzp3xj?=
 =?us-ascii?Q?VQNOSvV+7d+QOTu1l/HvDNIYNi848DZ2OskzMnxUYDCgyd45ZVu/9kx82GCd?=
 =?us-ascii?Q?ALd/5qi8ak+WjReQ/FP83QOvWPGsvN+01tngyxk+am872iaihsLsirkm8Q7i?=
 =?us-ascii?Q?ofV9KMEFsNVfDpTkn/MwANA7/yWLhoh9rtEweRjq3BOVv/u5xnxr42pkxCLe?=
 =?us-ascii?Q?GO16y/cEE2FiD4F9TKK6f3jVSmuzj1FC4neDwBZHjrZ9zx0hdrv8fXZRsMLL?=
 =?us-ascii?Q?ECsXQic/EEPJw4zGIjl8f9PqpjOOoE9icnTdO73PloZ+6cJ0CS9j7phjs67D?=
 =?us-ascii?Q?V/N7tzsxVvk1MwlBV/QbcgDyFvnOTI1rXjWYxe1ujq7BPV/caKW7VHpZbFpl?=
 =?us-ascii?Q?v0dTA+RwpGng+DeyagcgWsWwmfc+zxbwJsUC21/29lHhuxKb0SpUljey859b?=
 =?us-ascii?Q?buPfbprY+WLvmrZyBFEmAEw3mwCERaxvGd3wgBV6+7YRjN3XKmJFXZrJV6fh?=
 =?us-ascii?Q?Caicu/0GWeo6hFwx2N4pvWMIKbinI0Ri7vtGtAN569UwAB+VDAMfR9YZTXIr?=
 =?us-ascii?Q?gvPAKh15v/EF+fCy53ieBMchYu4KbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B564517E27ECC64697554B3375D446A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f7d29a-c985-4a25-678c-08d8c3a4dfa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 15:53:36.5423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HnFapn/acYLWHgziv9OTl2sp/KJYTj4iGGoEre0+PwrMjBoAyhIS1g/JL5Ydf31I5b9LTT/Ira5K1a+8RzsOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280080
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280080
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan-

> On Jan 28, 2021, at 10:34 AM, Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>=20
> On Thu, Jan 28, 2021 at 03:05:06PM +0000, Chuck Lever wrote:
>> Hi Colin-
>>=20
>>> On Jan 28, 2021, at 9:49 AM, Colin King <colin.king@canonical.com> wrot=
e:
>>>=20
>>> From: Colin Ian King <colin.king@canonical.com>
>>>=20
>>> The call to find_stateid_by_type is setting the return value in *stid
>>> yet the NULL check of the return is checking stid instead of *stid.
>>> Fix this by adding in the missing pointer * operator.
>>>=20
>>> Addresses-Coverity: ("Dereference before null check")
>>> Fixes: 6cdaa72d4dde ("nfsd: find_cpntf_state cleanup")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>=20
>> Thanks for your patch. I've committed it to the for-next branch at
>>=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>=20
>> in preparation for the v5.12 merge window, with the following changes:
>>=20
>> - ^statid^stateid
>> - Fixes: tag removed, since no stable backport is necessary
>>=20
>> The commit you are fixing has not been merged upstream yet.
>=20
> Fixes tags don't meant the patch has to be backported.  Is your tree
> rebased?  In that case, the fixes tag probably doesn't make sense
> because the tag can change.  You might want to just consider folding
> Colin's fix into the original commit.

Yes, this branch can be rebased on occasion. Since you and Bruce
suggest squashing the fix into the original patch, I will do that.


> Fixes tags are used for a lot of different things:
> 1)  If there is a fixes tag, then you can tell it does *NOT* have to
>    be back ported because the original commit is not in the stable
>    tree.  It saves time for the stable maintainers.
> 2)  Metrics to figure out how quickly we are fixing bugs.
> 3)  Sometimes the Fixes tag helps because we want to review the original
>    patch to see what the intent was.
>=20
> All sorts of stuff.  Etc.

Yep, I'm a fan of all that. I just want to avoid poking the stable
automation bear when it's unnecessary.

--
Chuck Lever



