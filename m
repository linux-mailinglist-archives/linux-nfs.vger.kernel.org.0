Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9578328A96
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 19:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhCASTS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 13:19:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56684 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239547AbhCASRD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 13:17:03 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121IF3HZ080169;
        Mon, 1 Mar 2021 18:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2wYsdHOmE5Ez7Podz3S4eL2INP+3P2xcGn8oVGerwdY=;
 b=N8oW/Wmi+mBP8XLmeaATGH/wiaNi/yuz7ot73rJh6mzPdtLALQm2lNj7LUMGRIitlJp+
 KiHPFVDK3ryuR3Fu4SlWJCVMI5IBY/OcJ3p2+zxYWje0Ia8llR0M6F5GuSQ9AWLsda5w
 uI4UVLRHzLCWaRoKTUVHNnikLjHgXYju2eRyl9cF3/5yeq8sjNKRSx/8e31X9jg9KCZ6
 aU5No6UEFJxoR/5jZ5cEOtKKmOo3zYUfGyrZveIgV2xgjKx/c8RW4vcoR1qVR31FweL5
 6Fu5hAAoss6CU02CXSrdY4wQylWwiMegih31jnQ/504wSRmsrQ1VwNId+/LF2AWECAuJ xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36ybkb4ysv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 18:15:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121IEvCZ172534;
        Mon, 1 Mar 2021 18:15:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by aserp3020.oracle.com with ESMTP id 36yyyxtju1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 18:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkfeVz9G7Jakh+g/89gIAZk/s4vFz5VlZFnkYuJ3oNPepDZnJFWYr/yAmkStZOFImBiPpRToVWSESDa5wdgGjwabdLXO/tnq0H5pmrnlT/ZLNBnU4f1cjcQ1qw/xBeXftk2Az3XR/X42dHcM5qZmBoXwlZLH3M5A4w6ekLd/lt0hRSzia2ZwTu7CNye6bRw4rLD17zqSXSD/80FIvGK68BXKqnR47TMFWWRr7nxqV5aV0XI9nAlwkd6vas2K2+T51iaF6MYhRygTXUTey+RQd9OrKOyXlbjdgG9RsOB1+eLY/yX7eKXqZbeUDmxEqa52hbkUzgiUYOJY7R4NGJXqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wYsdHOmE5Ez7Podz3S4eL2INP+3P2xcGn8oVGerwdY=;
 b=eqMe8ZpubtXzRQvDxKdy/8uBvW90+NVeEwW/QaXAUSNcMMGuuOHOlXxcXnlpXDAl6lJFB92QL1l8FJqLkSnK6JEIyPIiu9oEfz/D+8diAdaP2UnS6z8RgWolY1v8hCA/cqRPhM8RhthVXVU0V49Pwh5L+HHqJsm2FyPcWStPvDW8Y0F1R302lCnXiZvewMDkO05Fly1KRKUWM+YCRQYbL2cDnge4ZED/vLWPYbJYm/XuWJy9T+8Tz3cj8TSut53ZGoYpOv6btlE3gfde+FEfv32b8lHjsgzz9y8Ol3HPwwZ7/n/cjSayfVRK5vZYtSKBxoXyrQ3qKPw+2iTdBAyg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wYsdHOmE5Ez7Podz3S4eL2INP+3P2xcGn8oVGerwdY=;
 b=Mt4vYd+TpH5M3FGC6JZI6Pqd8YkrkLCgLbpZrfYqQYs2sFaa0mOCQ5zb2GlNRuCpcU1h+4+QPHjmx1aHLkv9jGTyr5RX8ul9GZVgn54vnmNbnMwJnuqZiXS1mvwr/ERuB+eKRdjS74XQvlrxC+j/MYdnXJVdF7w8MRzoheSVzpU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4387.namprd10.prod.outlook.com (2603:10b6:a03:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 18:15:49 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 18:15:49 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Bruce Fields <bfields@fieldses.org>,
        Olga Kornievskaia <aglo@umich.edu>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
Thread-Topic: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
Thread-Index: AQHXBx34swLJIWTQDUGQ7+S0CzclJKpgO7iAgAAGZwCAAB5zgIAAtPyAgADsxYCAAoIDAIAANauAgAAEVACAAAIEgIADLDCAgABAbwCAARU1AIAGPWUA
Date:   Mon, 1 Mar 2021 18:15:49 +0000
Message-ID: <4F649BEC-C222-4D16-B8C1-D1432690498F@oracle.com>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
 <20201029190716.70481-2-dai.ngo@oracle.com>
 <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
 <20210220010903.GE5357@fieldses.org>
 <69ea46ff-80d1-acfa-22a5-3d1b6230728f@oracle.com>
 <20210220032057.GA25183@fieldses.org>
 <CAN-5tyHq2NcQRbx01cSyJob=72MDUnwjK_t6GiDjTc3twbnvwA@mail.gmail.com>
 <ef11a2f9-f84b-7efc-ba5b-ca36c33d1825@oracle.com>
 <52e26138-0d3d-bd3c-6110-5a41e1fdf526@oracle.com>
 <517d8f58-4a00-8fe1-ad5a-b19ed50a8fe3@oracle.com>
 <ff068f05-c9cd-9772-4be7-74ae28a268d7@oracle.com>
 <a5cc3d04-06bc-6f3b-3ac2-c96a8efb1194@oracle.com>
 <CAN-5tyEXPxb7SZv_qmCECPUSdUgWSrPigrWxTORC0ZrMAj08Fg@mail.gmail.com>
 <7771b9f4-3689-cdca-5dd3-ef77e239ceb6@oracle.com>
 <1d52c88d-0c30-b9a1-9724-596bf7de314c@oracle.com>
In-Reply-To: <1d52c88d-0c30-b9a1-9724-596bf7de314c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bafcc14f-bd83-4e0d-3fd0-08d8dcde0aaf
x-ms-traffictypediagnostic: BY5PR10MB4387:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB43876CCCE45E1AC1E20B1E52939A9@BY5PR10MB4387.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SlslBIAJ4M7VMlKWFwpxsGZeo49ZUPmfKjdWo3Z+h9ef9KF2D1HMn5oAMzngMFRiKLaDK2e8IaK+SiwJx5oD67EQD4Hazb25oVEFqIemfSZBG2Pr9Hsm00vmgSAtqI/JSaahr6QnBQ/j9pJmFr6VnMdiGzOpUARdiTcFu7XwqGHDEkW3d0dHlBmxI0XvtkogdVM/+IUA3WdpsIB3X7p8Y0Bxtx9JIfKBbOB5eY4AyE8ioMfl2K3C2jUFe2LV+KrLL6G/ByX7GGBzgQWtLOnztAqlCprAi6RXs60983oO6zMEpsNpQYkTLRfgWCifTC+y8t4VTUwGYPifakzE1QN5sBQp2m05NjDYldvYagDgKDLdUkYNdDd/bKfinS5l7P5VAiXrBu4HI+sRV2FTuLT3rrkLsZtkA+GgZfy8cUWe9QgKhmkTbGQcrdcG9pMHVssraIwSEpSpmn4PsRajSJl3J4k+JKMuLMAlkXRBkFNM5vxliaCobuhCu0RX0skg2PBxAaXSr3ZQR2DRT07v4NXtBJ2zPQpv3QyiVqGza/oyqP7E1gRD+IOYLIZN6WqKOTRRBu6REpIt/VQ/EHqOFe1m8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39860400002)(376002)(8936002)(6486002)(316002)(8676002)(53546011)(26005)(478600001)(83380400001)(86362001)(110136005)(2616005)(6506007)(71200400001)(91956017)(33656002)(76116006)(64756008)(66446008)(186003)(66556008)(5660300002)(66476007)(66946007)(36756003)(4326008)(44832011)(2906002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KmaS1r2B6ytj5EpZRqP6PXlwbCTpnslc7pZqSgMm7S7S3fCUMH7OIIs3zNq9?=
 =?us-ascii?Q?NkfOzj0/KuEfZnORO4NDd3Z1N0E7xfyN18A1F9ENX5qDUt9hyOc70tRALVHC?=
 =?us-ascii?Q?rP5VE5LLQDgAq1Je7cSHUwUSniUiXoWn1v6e4l3VIhzKyc/WmoXqP/RRrGLJ?=
 =?us-ascii?Q?5IMFEQJ7tkLBnbbXWrwKbQ944rSMrvNRFgYgB9eXDOsNUC9p39kylZ4B+0kC?=
 =?us-ascii?Q?kySGNf4B8jjrjPBHb6q/TgE1dAhIkWtjKesXJLVOik2Qr8DgtxdqGDW3mbfp?=
 =?us-ascii?Q?Tk/iN+glZUI3WhQDxfumTz92nBwz3gBOf38spJeuT4OKXsfJug6+mBRHh4J0?=
 =?us-ascii?Q?oVRZt5kc406JKvZSL1znbpupratIpdzhF+2sblQLcsBNOKlZgZBpVx6CgM06?=
 =?us-ascii?Q?MXXU8nptlbF6MiKp10HEM4vNjOWJzOb70mnPzQdfwjn4kWnczTjWxynB+FUo?=
 =?us-ascii?Q?wVmQVn7wjI1NGQP9Va28HYg+NiSfOiO3K8DE4dSauOb1eISDWjSAlHqHocND?=
 =?us-ascii?Q?StqWU2ftchcdegXXmEN2eDCbJzPg1owstLInKoaBrwDZFLhzrNBD7/dZo0IK?=
 =?us-ascii?Q?RZYfuVhkJ7MLq56gEZXC/pNY2MCxwYSVzYXO/9SF/6XyBviy+xylItWuIvpt?=
 =?us-ascii?Q?kwPSlUHZqUdfGPCUfkc2HhYBQdfCutrkIq1mzb+Qlz3KVxq/tL/rjiPkjizi?=
 =?us-ascii?Q?8GK48kVskkT2XPgYDmpg/4TyftuDlMmtzcgDtG7H1mazbPdQ8E5gXmLfVGpj?=
 =?us-ascii?Q?N9QuqdbGD+QK1g+CCCWptQ59AmXzo7548W9UaPhOutqQTCCeeDHiDJGOcsxz?=
 =?us-ascii?Q?TlW51xo3JbOQWSTBPIkxczMYrKkVRxQECOurUrvOheF5VARV73m4fBqxMoMF?=
 =?us-ascii?Q?7pR/GF7VTwDARokxC9p3z9rj/pp5b7P4O74pInCoc+iJFRE+7eLyG1f02OMd?=
 =?us-ascii?Q?iNWPb3/Yp6cSoDG2f90bw+m/uiza2dnKjCywHqwd2QS45bJfvZkyg3ymuKBC?=
 =?us-ascii?Q?avUZ/e1uI/IPNTkFOQ95Pd5FD6H2faZZQNDQOqV3TU7NLMOSbMa2AUkaIrIi?=
 =?us-ascii?Q?G6bVERVjUBen6GguIgExQZVCjRcvSDbH4PRAgQvQi8D8xQRob/qgK9yenF1R?=
 =?us-ascii?Q?BPaZlgSbqHtbI3js1/mktoXG4vsfqSVQfEOGoYQBy4sSWAlw3+Aj7G4TT4+6?=
 =?us-ascii?Q?/maxe6zp5PQ3jLi4bu9RltKbCvY48TC/vrInJGvCER7WlmHifvVVVNRAb2XS?=
 =?us-ascii?Q?FatRlaDm+gXXcltKTmHSZPmO1ITbysN9sWU3n4nj/IPVrAgelm2SgHS3undk?=
 =?us-ascii?Q?+Zr76LXd10uUgPRueAwqQAoK?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDB2125DDF16FD4B88D113E9F6B46FFE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafcc14f-bd83-4e0d-3fd0-08d8dcde0aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 18:15:49.2425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FPewgCojDAIrE99atgy/T8wNhJu0rVnsgXExz+wLMJvvAkzQ6x9D7uDc7tmH0tKX0gURm9ma5QCZy/JMz+xCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4387
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010147
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010147
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 25, 2021, at 1:58 PM, dai.ngo@oracle.com wrote:
>=20
>=20
> On 2/24/21 6:26 PM, dai.ngo@oracle.com wrote:
>> Hi Olga and Bruce,
>>=20
>> On 2/24/21 2:35 PM, Olga Kornievskaia wrote:
>>> On Mon, Feb 22, 2021 at 5:09 PM <dai.ngo@oracle.com> wrote:
>>>>=20
>>>> On 2/22/21 2:01 PM, dai.ngo@oracle.com wrote:
>>>>> On 2/22/21 1:46 PM, dai.ngo@oracle.com wrote:
>>>>>> On 2/22/21 10:34 AM, dai.ngo@oracle.com wrote:
>>>>>>> On 2/20/21 8:16 PM, dai.ngo@oracle.com wrote:
>>>>>>>> On 2/20/21 6:08 AM, Olga Kornievskaia wrote:
>>>>>>>>> On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields
>>>>>>>>> <bfields@fieldses.org> wrote:
>>>>>>>>>> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wro=
te:
>>>>>>>>>>> If this is the cause why we don't drop the mount after the copy
>>>>>>>>>>> then I can restore the patch and look into this problem.
>>>>>>>>>>> Unfortunately,
>>>>>>>>>>> all my test machines are down for maintenance until Sunday/Mond=
ay.
>>>>>>>>>> I think we can take some time to figure out what's actually goin=
g on
>>>>>>>>>> here before reverting anything.
>>>>>>>>> Yes I agree. We need to fix the use-after-free and also make sure
>>>>>>>>> that
>>>>>>>>> reference will go away.
>>>>>>> I reverted the patch, verified the warning message is back:
>>>>>>>=20
>>>>>>> Feb 22 10:07:45 nfsvmf24 kernel: ------------[ cut here ]----------=
--
>>>>>>> Feb 22 10:07:45 nfsvmf24 kernel: refcount_t: underflow; use-after-f=
ree.
>>>>>>>=20
>>>>>>> then did a inter-server copy and waited for more than 20 mins and
>>>>>>> the destination server still maintains the session with the source
>>>>>>> server.  It must be some other references that prevent the mount
>>>>>>> to go away.
>>>>>> This change fixed the unmount after inter-server copy problem:
>>>>>>=20
>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>> index 8d6d2678abad..87687cd18938 100644
>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>> @@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount
>>>>>> *ss_mnt, struct nfsd_file *src,
>>>>>>                          struct nfsd_file *dst)
>>>>>>   {
>>>>>>          nfs42_ssc_close(src->nf_file);
>>>>>> -       /* 'src' is freed by nfsd4_do_async_copy */
>>>>>> +       nfsd_file_put(src);
>>>>>>          nfsd_file_put(dst);
>>>>>>          mntput(ss_mnt);
>>>>>>   }
>>>> This change is not need. It's left over from my testing to
>>>> reproduce the warning messages. Only the change in
>>>> nfsd4_do_async_copy is needed for the unmount problem.
>>>>=20
>>>> -Dai
>>>>=20
>>>>>> @@ -1472,14 +1472,12 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>                  copy->nf_src =3D kzalloc(sizeof(struct nfsd_file),
>>>>>> GFP_KERNEL);
>>>>>>                  if (!copy->nf_src) {
>>>>>>                          copy->nfserr =3D nfserr_serverfault;
>>>>>> - nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>                          goto do_callback;
>>>>>>                  }
>>>>>>                  copy->nf_src->nf_file =3D nfs42_ssc_open(copy->ss_m=
nt,
>>>>>> &copy->c_fh,
>>>>>> &copy->stateid);
>>>>>>                  if (IS_ERR(copy->nf_src->nf_file)) {
>>>>>>                          copy->nfserr =3D nfserr_offload_denied;
>>>>>> - nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>                          goto do_callback;
>>>>>>                  }
>>>>>>          }
>>>>>> @@ -1498,6 +1496,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>                          &nfsd4_cb_offload_ops,
>>>>>> NFSPROC4_CLNT_CB_OFFLOAD);
>>>>>>          nfsd4_run_cb(&cb_copy->cp_cb);
>>>>>>   out:
>>>>>> +       nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>          if (!copy->cp_intra)
>>>>>>                  kfree(copy->nf_src);
>>>>>>          cleanup_async_copy(copy);
>>>>>>=20
>>>>>> But there is something new. I tried inter-server copy twice.
>>>>>> First time I can verify from tshark capture that a session was
>>>>>> created and destroy, along with all the NFS ops. On 2nd try,
>>>>>> I can
>>> Hi Dai/Bruce,
>>>=20
>>> While I believe the fix works (as in the mount goes away), I'm not
>>> comfortable with this fix as I believe we will be leaking resources.
>>> Server calls nfs42_ssc_open() which creates a legit file pointer (yes
>>> it takes a reference on superblock but it also allocates memory for
>>> "file" structure). Normally a file structure requires doing an fput()
>>> which if I look thru the code does a bunch of things before in the end
>>> calling mntput(). While we free the copy->nf_src in
>>> nfs4_do_asyn_copy(), the copy->nf_src->nf_file was allocated
>>> separately and would have been freed from calling fput() on it.
>>>=20
>>> So I guess it's not correct to do kfree(copy->nf_src) in teh
>>> nfs4_do_async_copy() I think that's probably where use-after-free
>>> comes in. We need to keep it until the cleanup. I'm thinking perhaps
>>> call fput(copy->nf_src->nf_file) first and then free it? Just an idea
>>> but I haven't tested it.
>>=20
>> I think the unmount can be treated separately and the fix seems
>> to be valid for this issue. I think kfree(copy->nf_src) is called
>> after nfsd4_cleanup_inter_ssc so it's not the reason for the
>> 'use-after-free' warning. A quick look at nfsd4_do_async_copy
>> I see nf_src was kzalloc'ed but no ref count added to it.
>>=20
>> I will review the whole cleanup part and report back.
>=20
> I think this would fix the resource leak problem:
>=20
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 57b3821d975a..742fc128fdc8 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -405,6 +405,11 @@ static void __nfs42_ssc_close(struct file *filep)
>        struct nfs_open_context *ctx =3D nfs_file_open_context(filep);
>         ctx->state->flags =3D 0;
> +       if (!filep)
> +               return;
> +       get_file(filep);
> +       filp_close(filep, NULL);
> +       fput(filep);
> }
>  static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl =3D {
>=20
> -Dai

I'm not clear on the final outcome. Is a code change needed?
If so, can someone post a patch (with a full description and
Signed-off-by) or point me to one that's been posted already?

Thanks!

--
Chuck Lever



