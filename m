Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14A8351BC9
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhDASLD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 14:11:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58610 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbhDASDw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 14:03:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131DYSlF095814;
        Thu, 1 Apr 2021 13:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DFC5OajthiEKpBawUIB+cUFW/fSCw5JZGUglPqN5LHI=;
 b=ocxlPnjW2/9uC9dyE+8REE+JPjbdyjXlCTBVJpinCPCQz/jA/dW+fvAcS0tMbElfKEyM
 k8S8aBCO+NGUELyQNHrM5oZqGz9/bQWzzAcajhLgPeeOhhjkSG0fAXIY8koQDxMZVTfq
 slDAWUUqvdEZzV62t+CVVJiciti7zVHG/AwWj8Tm56IUlXI+O83IpFnbT0/5voXl52fi
 LsCb0D20GK6hm13IcbEQzjbJQ5sM5cou2kM6N65rcZwzFOw9olUdTsnFeYe/uIadf5+I
 /xBFyFy6ecIn/53E3GM/XkAtoe0dEglONT6yTcCjCEAGEDvHpTD/gp8bJCWcpkgM9thF 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37n2a01thg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 13:35:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131DPip3109979;
        Thu, 1 Apr 2021 13:35:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 37n2as9uck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 13:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK+G058mgFu35E90qbLtp+piuEqgqm/+nnMePgRAIWFHy1ZMkWirgZ903RDG8l3/E04Ca0hvP8K9wWbcO1pcz7gZo56t9/N9HPzyY8TJBmy48kKNI1H9CkwGbKhOY8yJik/IOL41Ed5KWVHa/SoxOCiOW7e2FqwndOWYMm/TJB/gdvgWnbnRdRMLMCDkBPVX3H9MEMI6ypWKiTs1UVcXHdrTsOXAOZ45dWZGrqRZgYaQzpw6D0MTFhDb8+l0ye/prgEN5vNAxbZ/EZfmm5c/c+ZJGMjsSHOkoZnCuQ8je2WfoW9hzxOuYByXbpF2Mpdk1zn9nNOw9wu6gQUJPur+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFC5OajthiEKpBawUIB+cUFW/fSCw5JZGUglPqN5LHI=;
 b=AY3Qnh0E9hQCMxju3SpHkn5Txy0vJe7yQMJGnEgjeqp6oe8lzY/aZQy0SmZun4grFqVYvuBzCut6rxrQ3JgtmZVMLVD1eOa8tXAed92eLSFV9NjoYP2l2gYTK0tDi3Ya2Kkk0BspECekji1anT679BP6ry6PfnZa4mZWt/fUspSVQobuj0gKcxtw4xtheWkpdlrEO6GwgxcN1jM2D+iGxAISWW82nu4TqEuxAGsGjN/+cMcMDbVWFRXKU5Sx4iC16K2YEmGeES/Zs7+eGgnA71Cq1BKlwiyAT85Y50tRVG33dqz3sIbiBTKqCx9q9LJHdxp+v8b2I4CUkEox20jiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFC5OajthiEKpBawUIB+cUFW/fSCw5JZGUglPqN5LHI=;
 b=tkX4yduqVqabrkP8XGirwHZqx40nl6Wm9rv/tCMKdusuUqex5bi4iz8deBJMEbsRGtD20S5O37TDh+rSd6a+BXWmE1ZWwH0gIODbMrlvVPsfuMr2ACi0E5S2B81gWjpmfvAU0jHJl8PVEXk19b5elgP27yvuFOm4eepw8gDIn9c=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 13:35:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.029; Thu, 1 Apr 2021
 13:35:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.2: fix copy stateid copying for the async copy
Thread-Topic: [PATCH 1/1] NFSv4.2: fix copy stateid copying for the async copy
Thread-Index: AQHXJZd18veVkGmMdESYIByvSvllAaqeTagAgABHT4CAAReQgA==
Date:   Thu, 1 Apr 2021 13:35:19 +0000
Message-ID: <858F499A-0687-43E8-A67F-BFC462623EE4@oracle.com>
References: <20210330190359.13057-1-olga.kornievskaia@gmail.com>
 <AAB69ABA-6AD8-4623-A823-B1B3FF8BA1FB@oracle.com>
 <CAN-5tyHL4s9=Gaf=DzA3H2ZcMzMn00Lqqw+h-ZgSrogVUHJ1Rg@mail.gmail.com>
In-Reply-To: <CAN-5tyHL4s9=Gaf=DzA3H2ZcMzMn00Lqqw+h-ZgSrogVUHJ1Rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6f415a8-cde6-46e2-301e-08d8f512fe63
x-ms-traffictypediagnostic: SJ0PR10MB4495:
x-microsoft-antispam-prvs: <SJ0PR10MB44958FA415367C0964FBC163937B9@SJ0PR10MB4495.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHhZ6OzDPWidbT0n3BWTBlkkeBZBLNHiIcnlSzEYhy2GnsnIIKk2Ni8TSAwYUJ2Zdp30ilFuItsl/nVwqbQY8L7Dw4LVPBkzSNCBRCaZqCQSovr/ShfslP9KVs1An68PuhdwGTO2mN90OgvKZPn9nBZHIu+lpQ3W2BUOnGR+fHSicTsZ4kmcZNhBD3v7UWzN2fCoSWlcYPSsnP1kvPTRaLzSmaG8G5wrc6TQRoM8OVyJpIKZElf3qrM4I0s1GKu7Bo39K2/bfHFWTVIpyNtz6LDG3a9ORyut5+HEVjWzSlxaluLSXDDEr+JewqWSCp4XaxsOxByR9dwnr/QK3hmbSPJqBtVJpR+BVht3OyAzezAVtkvTLg/VnIuGzcD9slJocMexmJXad0fEsBUsW5ZVlzBSpU975vX5Ket19bx9Q1mlUtptIs29ie2WCZ71h93iKNnKWW9fz6vMCg+VoUmspFVz7ClooPncgYabO4g6lfcj6vA+qjKwg2K97ueC08PuQg7WCBBGau/At0uJEjq2wQ5Ocw/Hy4gElFvjs7B5xGFFfpN/JzWC/Z3nBEtvTIrpFJxrI8BVOwFdJUM6ucLwyftRVDqnFIJEoPhflaZB9MOqi3ETz3kURxhdyUszMY8h+GIoqhvIhoJ9ITM3dV96sYHCTKsYhureRjHAbzxFrYhOgnbCTtbb566Ofa5AXtKr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(86362001)(8936002)(8676002)(2616005)(6916009)(6486002)(186003)(6512007)(26005)(91956017)(76116006)(83380400001)(66946007)(66476007)(64756008)(5660300002)(478600001)(54906003)(71200400001)(4326008)(36756003)(53546011)(6506007)(316002)(38100700001)(2906002)(66556008)(66446008)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TQSAhEvhceepxBrnJLVdwKtYzxP77eVxFxiQZQnGLMxXnega0DPVjVN3H4Uv?=
 =?us-ascii?Q?Q6XsXli1ScliKXU96MnO5WAGNgXlQuEtsXF1nLzeiBZeh2X0seoy/iIRoA26?=
 =?us-ascii?Q?GQI3KUXjp6+yKlRYeEx4kualJ8Qn3hB9GxDa0Rl2NI/kHoreuZdCuaZVCBJn?=
 =?us-ascii?Q?iazy5qxkfG72z36ywu3UiInMfjBCNkrxHaLFRXFXxcrP3VdxWRXJtKtfhhVu?=
 =?us-ascii?Q?OKCSrk2LRt7vlbnIBvcd1NshLF1j5QXmFGQzNAmTQR6YCwSOh6BqBVU40Mql?=
 =?us-ascii?Q?Gty46PSPRmXEqQiS6RS9sFJMlQiOWnLA/HFkbrCBclk18pK+bjFEQ2MJ/4er?=
 =?us-ascii?Q?J+oAgM8o2GubSvjQ4Du/Wj/PYHam4A+Mjzn5hA8YIzZ/mVPjzyDkj6ei7qU5?=
 =?us-ascii?Q?wJ1NZG5yljPueFGj8bR4sIWqz61OcdJYv2HfFiuR35tmlBM/vLQ7cvr1tf5M?=
 =?us-ascii?Q?fMUmlBksQ99HxHo+rkj3/XyNHoc4VUK84Ae9KOkQ4FOQGd2zPXowW+HSZAbu?=
 =?us-ascii?Q?s9CS0ANkNRnCdJjgS0+2IkP5CSlZE2nQq0ZdoNnRYa6Bc+XVLmef9LZIXi8Z?=
 =?us-ascii?Q?icGGPajgR0Sxw7ABySKCE9Fpa/mZDq5d/83a4ud3+WOYs1riCGPKBS6J9vUk?=
 =?us-ascii?Q?/5qIOf+ZfpprxNOvW1StZ6a0avfstBDQqDQ21twLLNuAdI6aaQoMDDcOm0U3?=
 =?us-ascii?Q?lfT6Vdn1ZHvkG59EzMnuw6QXgo0MG2viF39ZuwkfGRP46ZHbUifs0+9QI1LN?=
 =?us-ascii?Q?osqkhXGFVBRQJuavljZl2/uIckzD+dM/MiYutg3soL0H2NO3jk44sJztyTKK?=
 =?us-ascii?Q?gXP/mJC86J/jFG7Uzb9eh0I0C0jnsTVXGeC3OrIF3A7uHycSR0cLiHiyndRW?=
 =?us-ascii?Q?xDa9VvqVeVZ25YgZK91foDPYr2woikaPMx+mpM6EW7/30KzMyIJXL954f3E8?=
 =?us-ascii?Q?OsR33kAi/NyGJNBtE+cCB89UUACpezyvX/CFcKU8hfzZmdFrsGp4U+S5eZHE?=
 =?us-ascii?Q?pu+NM21ZjmuDIgkYflZ+W+L7WKEj/G3IpCgWOQiwFyrxNdHL6jyAAzu5l55h?=
 =?us-ascii?Q?qcFSXEA7ki9GzJUadPuenSzhCtnIeN+BHEw8c7fSYyxhXPPC3hfBXluyVe0M?=
 =?us-ascii?Q?bNkbM2gGOKv0yiagdkfq8ZBRHadWBf63rkBkZgt1PC5jt2nTInkV8Lgbp6M7?=
 =?us-ascii?Q?aCe4eWiWm/OAtnpcjpcpqj4Tiim3VyeXXKu1A9FTmxW1UMGSU/Fdd2XmDJdQ?=
 =?us-ascii?Q?twvm0lAF5HUwh0n+suoBXTHArM/H+58LAiPoy96ma6h64dkrWOUBTf+5LSof?=
 =?us-ascii?Q?fog/ENtv//eKfLjyQSAglc2m?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1AC2AEE671334489F32B58A85830B0B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f415a8-cde6-46e2-301e-08d8f512fe63
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 13:35:19.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGgvtdtuPdgqKYzFh3SiJLJA8aOw7x0VO5BlTYZ+UB7qaNVGE5NMQhkJs2umar6PflKimLJWQT1w5UXXyRu+8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010093
X-Proofpoint-GUID: A1abaENLP4xFVrV1dLRXlmTSSy43zXqB
X-Proofpoint-ORIG-GUID: A1abaENLP4xFVrV1dLRXlmTSSy43zXqB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010094
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 31, 2021, at 4:54 PM, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
>=20
> On Wed, Mar 31, 2021 at 12:39 PM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>=20
>> Hi Olga-
>>=20
>>> On Mar 30, 2021, at 3:03 PM, Olga Kornievskaia <olga.kornievskaia@gmail=
.com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> This patch fixes Dan Carpenter's report that the static checker
>>> found a problem where memcpy() was copying into too small of a buffer.
>>>=20
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Fixes: e0639dc5805a: "NFSD introduce async copy feature"
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>=20
>> Thanks! Pushed to the for-next topic branch in:
>>=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>=20
>> With a Reviewed-by: from Dai.
>=20
> Thank you Chuck. It was pointed out that I messed up the "Fixes" line.

Interesting that checkpatch.pl did not catch this.


> Do you want me to send another or can you fix it locally?

I'll take care of it. The tag change is entirely mechanical.


>>> ---
>>> fs/nfsd/nfs4proc.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index dd9f38d072dd..e13c4c81fb89 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1538,8 +1538,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>>>              if (!nfs4_init_copy_state(nn, copy))
>>>                      goto out_err;
>>>              refcount_set(&async_copy->refcount, 1);
>>> -             memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid,
>>> -                     sizeof(copy->cp_stateid));
>>> +             memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.stid,
>>> +                     sizeof(copy->cp_res.cb_stateid));
>>>              dup_copy_fields(copy, async_copy);
>>>              async_copy->copy_task =3D kthread_create(nfsd4_do_async_co=
py,
>>>                              async_copy, "%s", "copy thread");
>>> --
>>> 2.18.2
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



