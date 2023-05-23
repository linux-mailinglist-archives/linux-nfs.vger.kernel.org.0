Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C3670E91D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 May 2023 00:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjEWWe1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 18:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjEWWe0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 18:34:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12BBF
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 15:34:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NM4SOC001379;
        Tue, 23 May 2023 22:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jwF9O49RmI9z2+EHkbVnTLuopy+ovpOl+H5FROPS7as=;
 b=zkt96RMwTz5KPsYJkanlvzC4vvQB+OvcFJ2VHyoS/PsXRwf8NcSZm0eZQI08gyUwPy8D
 8WHSdqgBemRijroA//+NLD/rNIxgz5v4BzovPsfnRdc8u0ErzCXeDhrauGy2npHibFH/
 WCaYqeBwrrBicFK99P8Bcwbvcb6G5d1aJ4DCDZK7qJHP/Ua9FHW5LcU+7W6ALN4jfxDO
 qVUGuoxu8B2HVGU5IBhB6o36GskaqTBGvKmYdRb9Mkr56h1pU+aQDa0VsQKCZw+vdiAj
 XgV/+MmjEP70T7unwe/6g8eYmFVUm5TlpVPAs3I14VVoqmO8tQXD9D2MyujZIUTJ41fS OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp426cq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 22:34:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NLb9So027619;
        Tue, 23 May 2023 22:34:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2e6s5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 22:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr5JmV3xdiXXhVKuarx3LaBNW2H4SMB/ccx00u6+MEyMRgdK99mSkgI4BzqRcNVaR6veTszMNoMJuN+OYwCP/z1Fdae2CrccjYdFU+q0PgIKXlz3vHKBkcyC6SBx4LUAo53AqZQMk6vB1PtFUoqz6sWEA0PSWtgqqi1y2zJ+5QVMXyZfxeMJr3VPkxYE/24pkhWuwSCmCT/qksAWCD95dYBBZmvDZu5nRIq4HZymP45AObehfp423L8vtB3O3BpojcIbcZJOZPvZciAi6q/m2fMzH6QkDkwpMokiEM2HpRy2iCj9IXUt6/H5LR0Gd9TgE6a9riqgWZjhNNUWh4VnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwF9O49RmI9z2+EHkbVnTLuopy+ovpOl+H5FROPS7as=;
 b=Id4v5wYKDQiK5Wcm96fHx/r/JjpTJAkWmuzn73v3Px32ZrZB5JmOpMyXeTkcCN1YHkdau/u3SEA/rwYpzs5h40wCdWTX4JLSDtYD4JA28xNqPTKvaBf4riQINfM6vznc8eaUTUKVp7vyOBXbpivj5op5ZXZskrnFeDgomyrBE+aQxast0QOKpErCoUiMFER5qIWi7IynMSgeUY+Wge+8g+ahiYnLMNjq8jIinxRCQDIHPPBNEKKUHXBzt/mnXwAerPdDGWxl0WLrfyGDrBJQhzKt8QyZXUsd9E5ThKS65+zJr2ELnQPj6NMIap6s17Ehxq2wgkZjN+ZogcWEfOMWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwF9O49RmI9z2+EHkbVnTLuopy+ovpOl+H5FROPS7as=;
 b=x/4AIp6hnkDrlvBvamo4W0MKFaIYwqNu3NqtqMeqRryLpEaNwM8CZtu1P4IrCFfpnnkVmUhy+y6/3hriPzWnOk5pk+X5u/4FETHlB8bIrfosewUDKUBSDHhn/yUgGFoMN9dB0m/NED5lt57E5M/OzCnBbtWANJ/79B0jq7XNEtc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 22:34:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 22:34:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr fails
Thread-Topic: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr
 fails
Thread-Index: AQHZikOAXGHeeefv3UWBymioFz6Qoq9lg78AgAJXrgCAAJTyAIAACHcA
Date:   Tue, 23 May 2023 22:34:16 +0000
Message-ID: <41431E7C-26DA-4D89-A5EB-44237AC405BE@oracle.com>
References: <20230519111723.20612-1-jlayton@kernel.org>
 <168471866230.5298.3283829268036917998@noble.neil.brown.name>
 <143D2797-B071-43FF-AA85-E4C4A7218691@oracle.com>
 <168487942834.21808.17784288972950301860@noble.neil.brown.name>
In-Reply-To: <168487942834.21808.17784288972950301860@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5171:EE_
x-ms-office365-filtering-correlation-id: 0a53058d-0ba7-4878-ffca-08db5bddd79c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJLUizOErfpUPexxWcyI+OHiiCg+8CJjiL7GAR+Vke+wjWrGpIrsOYZVaRrSCJ9GM85xZw36HjLHEIGcFpn9IifnXlMxZXprXNxA2JucaFaHRbWEGdE2KT8+lW/Q6LMnkni9mErSgkqqMHUHsKuovdUDAbPQUPYiZDqTA8m51C0sGF0oH+jmoAPVusM24xwV1FtQu4t30WJ0HeHaKdecMxFFCUXR69r9kritVZgNdfr3pXGTWVy5ClrBpLU/DiYG95f6G1DcG9pEYMs5bSGCICg+/Ijv1dr6h6nu81YRgj1gswBplNqbl+a4sJJpiU83mQpwV7ynXT1K+E7paKP+loiZ7XG3ROxvA5qT49wA7l6UIpGtIHbSYvD7wNZcgEa09PEDtnp/ZSQ8kxG2IOPkcvEIMkcOySBl6q8pB2DdS/ykYj6NQNvqO7zbk9I7t8i2PXEvY+mFkq+YAaYVEC2rxqQrEd4DGOjDsiaNq5kqo+8G0X4pnQQO5UZjDzZYp+Nm7Mth3gxUP9EP2JEJnVB0PNNr4senb7B6ptxodTtJO8OtbfCqbWkISMppBP+1gS6mfpYFFaLOksc4bY1ruJEV0zT+5JsIUmYSFn/zWziktbszRaoW+sGYnjyUe7bCW1dSfSxfRDksuA1ANMb6IImjiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(91956017)(83380400001)(8676002)(8936002)(5660300002)(53546011)(186003)(6512007)(6506007)(2616005)(26005)(86362001)(122000001)(38100700002)(38070700005)(71200400001)(33656002)(478600001)(6486002)(4326008)(6916009)(36756003)(41300700001)(66556008)(66476007)(76116006)(64756008)(66446008)(66946007)(316002)(54906003)(2906002)(66899021)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?06ETM0vqok7Hko09RpOV/WAPtGE/PKsPdVzlIqW6gN8i5WuTS0/ck7l9oIKX?=
 =?us-ascii?Q?8EAfTPb2JbvNTzAAmXMXYEjZpwsz6ddUcj9IdXLOH35nveMvODulN+ebShBz?=
 =?us-ascii?Q?TjUwRTuFYHAUH34ln0xtnXNZau2Zgv653OP77aflg/zu2kEDtK1N4K4+6av2?=
 =?us-ascii?Q?eXxm06lm1IT2i53yjgkPz9fFljSqjCOky1caqop/wmeNz/phoeZlf2tzQTNH?=
 =?us-ascii?Q?906mNGMl7CCyNf0Djw7KcT26wO5kP2tH8U0j+eMAvdVdX4lVkQiP3nXuJuVS?=
 =?us-ascii?Q?oU/WsSKBtxplHRH1tefyIBpXsDRSMowZPQjcy4X2VJLqXGEi3mrdBONK1tC7?=
 =?us-ascii?Q?LzGuEwjo/gCBD1D856i3NOf0KEdfvWAJE/rP8koejFK2ON7edlMrHfsGuM5O?=
 =?us-ascii?Q?uuZ8uAiAhuxHPSUB/v5N758Mn3RSc7pmVbqfTD2eXtfO1pb8o0lZQdceWmbz?=
 =?us-ascii?Q?HISYyhyKo0ypD5tqWlUEl4FnbzEZKXN5n/xymEj9cLggpzwW5/Zcz2OpJNhd?=
 =?us-ascii?Q?bbSOKRdsRL/q4xH5RWwo88j4A4v7Xm+uRCvL3ZLucST3lZoJyPyAaejwUUzf?=
 =?us-ascii?Q?BDYsoXf+DpGJy1u717oZq7/snzE7/3ZsppxwxFjL2dG48YTPJildqsYfJTbA?=
 =?us-ascii?Q?NGmbG24dzHUQSRHy292DexfXi8tGqfXH9jsHzuMc8az7uApKgvrJnbV2KPkb?=
 =?us-ascii?Q?6oYGIF4pqZaq06RT2PqM5lr0jB5n3oxW3OXJM91jQEGV3EhoF7ejnkAxJHla?=
 =?us-ascii?Q?I2yCBXujGE/NoEWscyAmmBA9KjmZ9gNwOhWZ21L7v2mGfdu8Wjbh6DeufyO7?=
 =?us-ascii?Q?gvWKiBACpnQp4kPTDsn7gC+oCFXns+xJc9MtBMtb+dJtIQQbelTzRfvgKcUZ?=
 =?us-ascii?Q?Z+rPlw8yD8lk+0oI+xIhKr+z/cT3eWtGyUfRxo5g/nlhqX0ewkdieKARlEn3?=
 =?us-ascii?Q?QWUkacCteafSCIYvfAFTLkECjwK4bFNhhMoksLt0Lqy9HlDaEqolGnknMHbJ?=
 =?us-ascii?Q?sBGY/EcPc4CkHf4JDnt3OA7F6L5m49uLzqbD4uVGmbywHIL90oMe0b3CpUyi?=
 =?us-ascii?Q?zWrvmUWtuWZOO/pyK7hQG0ZNR3SpVjvQppqRqiEikubV0YFCG2tiM1PIhRGv?=
 =?us-ascii?Q?ddsFq4kf2EUFzFh+GDLL4tLgxYkHgOEJDBRvdC42zS9hPXMx+lxy0B+fFRYE?=
 =?us-ascii?Q?TQ6E1caq5hjZPEW2HEM6F6oPCKNXUhy+jCm9/TQkCCK1dmQxjjQ65jZkelhl?=
 =?us-ascii?Q?Dzw5NUeWqIOj4xlgGPuT8fz6jZ01P/bdRcfvpHaqFwZ5DgyxnCcCC3SYt9PL?=
 =?us-ascii?Q?qgwVYnBVfRal77VwmMy4L3o4O10IUN2xH8mMYHYUTOOKnlEpdKnbQou8UtFA?=
 =?us-ascii?Q?9Y5xRX/NrtLxcpKDUwvG7kKHqM2L1eY51gXcWRlNttbCPLVdnKtrXThBvA+q?=
 =?us-ascii?Q?5qqbT1gTqQ6TuO0j/L7n0V8A5vR0675QBHdVB+7/DGAteFp28MOBUeHafIPZ?=
 =?us-ascii?Q?rjK7lafhNaSWikv7AnHvXFkTnn/0haXkt8/krIS+7PIp8O49ldmi9YrWyND6?=
 =?us-ascii?Q?IasJ1ERIdta1dRdAJyb9wq6RQ76dH/Mi7GbyzA2lwIpegbgXqzn5abEpCc8T?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <803E640BD2CFA4459B584286467F3B3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jvao8Ft7E7zsGMYDf2i1vsWHx3DnTLNclKmfVAgI6yXxb00nq9uFkYvZqLceLP/7ZhOy+GBfK3PCpftOZNyEjYnipdWgNN0/9X5K9XNNHaY23C3EZrfqA1mh012niYju9YEwLG+BNmc52gub6U/8/Uy/n6b3Y1SaCO8IJeVi4rFfa2TzAKCkphZqeqcxW4BxH2kjyXRPZRP2j7j+SBqIBXoTHbjUTIX6BfY2HkCSXAE2Dq8V03xsWMCdI3G1+/hoQ7EdcDwSIchfGnlm1W5RCX1vb4Z9RIc0uUyDsCv3bVeTVubCmBHpm9svBLnPiVo1K5llF3WQiltNka13c4GYo48bCxcvB3H9eNeHalusdSfjegmYa5yZy61pbmqBfNjpkqnjGWyze/9dGrDHq+zY1+L4voHyUi6f0brrcpm+ahrGX9sZS/t5LnvUMwbw6dTM+JPjOM10qzMJoOF/sQJmglyHro4d58CVvL5CJnv1fl5LUf6Rxb7ekscaqip7MyyfnObE5TF7YCZ0qWtykSIX+++Tdl0/HnvBYi0M/Odzo0BCzp9TjXjS151tF7xfxbm7aP6VgqeDKCxj6eS5T6lrA9Uvdbea5jv/MAsMODzVX1sl+qn+S2At42MnnoNpfh8FB7exf/j9qKFo4U5rcVFqcFnhGpFZ/YT7mgiBeL4Lg85cIHva9zDjr/4xkp9ITliG9TDcWs/+rDuJ59zLyfvtwBVopvrwTe6A65K+7idZbtV9x3ZyLeUTFTAVs1iyXuM7XjsTyeVmsrhoRXHRWoIRf8sYPM5KgGrmDDjzG5/RWhvJ997Wf/1oxJEtXoqmznqR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a53058d-0ba7-4878-ffca-08db5bddd79c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 22:34:16.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgolhUiEB60GlSb2fk6YyRXrHwOfxWm4eIbHq5aOEg0ayZkK8O3vSYI+CpSw9wm5New0ie6Qu48QMSHKhahgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230180
X-Proofpoint-ORIG-GUID: wQOGedvqTUzEb-urS7_tNL4XngU7Hoqq
X-Proofpoint-GUID: wQOGedvqTUzEb-urS7_tNL4XngU7Hoqq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 23, 2023, at 6:03 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 23 May 2023, Chuck Lever III wrote:
>>=20
>>> On May 21, 2023, at 9:24 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Fri, 19 May 2023, Jeff Layton wrote:
>>>> nfsd calls fh_getattr to get the latest inode attrs for pre/post-op
>>>> info. In the event that fh_getattr fails, it resorts to scraping cache=
d
>>>> values out of the inode directly.
>>>>=20
>>>> Since these attributes are optional, we can just skip providing them
>>>> altogether when this happens.
>>>>=20
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>> fs/nfsd/nfsfh.c | 26 +++++++-------------------
>>>> 1 file changed, 7 insertions(+), 19 deletions(-)
>>>>=20
>>>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>>>> index ccd8485fee04..e8e13ae72e3c 100644
>>>> --- a/fs/nfsd/nfsfh.c
>>>> +++ b/fs/nfsd/nfsfh.c
>>>> @@ -623,16 +623,9 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
>>>>=20
>>>> inode =3D d_inode(fhp->fh_dentry);
>>>> err =3D fh_getattr(fhp, &stat);
>>>> - if (err) {
>>>> - /* Grab the times from inode anyway */
>>>> - stat.mtime =3D inode->i_mtime;
>>>> - stat.ctime =3D inode->i_ctime;
>>>> - stat.size  =3D inode->i_size;
>>>> - if (v4 && IS_I_VERSION(inode)) {
>>>> - stat.change_cookie =3D inode_query_iversion(inode);
>>>> - stat.result_mask |=3D STATX_CHANGE_COOKIE;
>>>> - }
>>>> - }
>>>> + if (err)
>>>> + return;
>>>> +
>>>=20
>>> I wondered if this might exercise error paths which had not previously
>>> been tested.  Before this change fh_pre_saved is always set, now it is
>>> not.
>>>=20
>>> The code looks OK, but I was amused by xdr_stream_encode_item_absent().
>>> Various places in the code test for "< 0" or "> 0" which seems to
>>> suggest that "0" is not being handled consistently.
>>=20
>> You can read those as "returns positive" and "returns negative" tests.
>=20
> That leaves the curious reader, who isn't completely familiar with the
> code, wondering what "0" would mean.
> It's not a big deal, but it looked odd so I thought I would mention it.

Code readability is always on point.

The return values are a feature of all the xdr_stream_encode_* helpers.
For _item_absent() in particular, we could go with "!=3D XDR_UNIT" but
that's more verbose and still not especially more clear.

Probably the one spot that is confusing is the "_item_absent() > 0"
call site. That's meant to mean "true if it worked, false if not".
There was again no real better alternative.


>>> But of course xdr_stream_encode_item_absent() can never return 0.  It
>>> returns either XDR_UNIT or -EMSGSIZE.
>>=20
>> I don't see any tests for it returning exactly zero.
>>=20
>>=20
>>> I wonder if we should be consistent in how we test for an error ....  o=
r
>>> if it it really matters.
>>=20
>> The xdr_stream_encode_* functions conventionally return a negative errno
>> or a positive number of bytes encoded. The "< 0" and "> 0" tests convert
>> that return value into a boolean.
>>=20
>> I reviewed the call sites just now and do not see an evident problem.
>>=20
>>=20
>>> Patch itself looks good.
>>=20
>> May I add "Reviewed-by: Neil Brown <neilb@suse.de <mailto:neilb@suse.de>=
>" ?
>=20
> Yes please. (though maybe without the "mailto:" :-)

Thanks.

I typed the address correctly, but oddly, Mail.app helpfully added the
mailto: tag when it sent the mail. Ho hum.


--
Chuck Lever


