Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB353F3F8
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 04:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiFGCgI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 22:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiFGCgH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 22:36:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A758BD20
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 19:36:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2571ZoR5019959;
        Tue, 7 Jun 2022 02:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3xZmVWihn7/KyP86peeQ0s7XeAnO7OCmoanW5DUwWf0=;
 b=Pzu8Ihi2GN0hYLccdo4qTav4v5IiRDnzVJcmSWeSfSLw9kd1ZedT7wquRJyniAR+6VKy
 N5xixbTbwnvSmuXkRE5aCVQEI52J4WHNycZ5SgQsZe7pn50U+2Yvzw1XzBZzInWD/pOm
 gYPxSt404PoqPjJWrJquWEOnq2AnYRXhP0L0x/6Vni5PVfX5QSS9AtYKRyxiN6b+o8gs
 q/Q+6EJWuPeY1BUrfkyIhbEH4ihhXXBsTFWqjnLwnDAWmXMlMEqkx+HJTO0q+OyJW4Jv
 xiL/dyJb1LgbF+Tx1Ex+39juWyt8I5i5ymqjn0N93KMn0zJC/7NC8sWikWhuRIO+K0pe DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxscmsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 02:35:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2572GWXS040925;
        Tue, 7 Jun 2022 02:35:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu22fq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 02:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnevBk18IhhmAvjTHBhWU6gHXBIv2sNWBf1Z02paYJYYb+8onJlqT9NDXUPxgZIGGqW9VgD9QPzlprYstighHkpUWLfPhGXuTENLX+WwdSDMaofNVNq1YxCGLb6n3HVPiuQ1GdVaH7t4DIPDQLzXoS+fkWd0w44dF5NjfC6KQsPXEAOE1s1I6NyIjl1Ct8/X0w13sUQaXPvsbQZ379CIQ9PvVVLAoSeWUWAb7CzD0Mi4yNzFOJR6PfnePwDLvKaH1F3XEioBqKG/IfoXPNuVvq6QSM1hRWZl4Wp0RXRq2bbaZh7DlZrqgnvSTTRdL6F1CzmTqAIEDr4wZsTGdPE8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xZmVWihn7/KyP86peeQ0s7XeAnO7OCmoanW5DUwWf0=;
 b=Us/JDbGsJVvVAJ0XsF2XXFzZE2U3O827cPreADgcnCz1EaN6bJi+IMOZO8lQy31W5GAN1I+u8ZLTWUZvDqztYqvNw+KIlJu602jRQRfvWGP8ZszLgU5siTVqCcEKme8tS2z/TOlhq7wIdSyKmi24YVUUFD3HrS/vPgriXrPlMr1GN3r6vlO24gqbwOet4L0fu/VUAD739LH5eW6kSWFEMrrw3Ioa14HzOswtHi7M2VK/J6qO66DdiU8frWJNWFy6Edby/dJRRO1vshshC/00HpStTS59pN1L8EhUr49nG7iNiH17lTdm3Uu7EJ4TjgbQsf7470vtxSKRBAgRkaEvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xZmVWihn7/KyP86peeQ0s7XeAnO7OCmoanW5DUwWf0=;
 b=VrANEr5Na/ZHQrNbwfdddhifJs/NIn8yJgQdO3fCV257AeqV/jvbeWrFYrDRQNCMV4WeSXksJ4kXGonUIlnZC7lFU2+c/ow3DmMRvY4k6HxUegUxODn8E1+ltY9PgD5uY8hNuKhEWyAQrGyUCDf1vX7wXWdTWN3G1bNa+7tYQA8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3030.namprd10.prod.outlook.com (2603:10b6:a03:92::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 02:35:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 02:35:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] SUNRPC: Fix the calculation of xdr->end in
 xdr_get_next_encode_buffer()
Thread-Topic: [PATCH v1 1/5] SUNRPC: Fix the calculation of xdr->end in
 xdr_get_next_encode_buffer()
Thread-Index: AQHYeRam8Dx7jt+RMEip5dpodDHiAa1C8gwAgAAvcICAABr1AA==
Date:   Tue, 7 Jun 2022 02:35:54 +0000
Message-ID: <D3608A6C-0CA9-434B-BF56-79AB33793AB4@oracle.com>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>
 <165445910560.1664.5852151724543272982.stgit@bazille.1015granger.net>
 <20220606220938.GE15057@fieldses.org>
 <165456356541.22243.8883363674329684173@noble.neil.brown.name>
In-Reply-To: <165456356541.22243.8883363674329684173@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f10cade-337c-4840-7b03-08da482e724d
x-ms-traffictypediagnostic: BYAPR10MB3030:EE_
x-microsoft-antispam-prvs: <BYAPR10MB30305DB2C840CB5F085BCA0793A59@BYAPR10MB3030.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+C5n0sUOt/Tw/DWQVPEtRAKj221FrnVC0GgjFisFY8Kd3TLt+5+HFh08lk7IRSOqSZpN8tgDG3Hx9NkAkdcHUTDfBJylDJGFOT0paj1yH6V3xVYD1+uhySUVn768ZvizGVxE/kuY2IwDUSQxMIeRiVlkL3ilKgUdUnziesXTW4cIRbxg6zRU4OJoVcfs+yxfc+KUkfY2vQuV4zIq2U5Zt52C1axqe+PMiW0mBLzOwp3V+43cGdMRNayGkeGuiw55vi4pEmNjKaWEIDxQiWslMrIctG0mstIlaBuPjhjBPVmsrKQEoitkns0Bua2cO+ueCowDkG8LS464uPU9Z/02ZrCu/KlzHRm1/5TNXHoGFQd2Zo7WgQT8RVr0OBKWd4lnPqTIgd7r0Iy8SV8Hi1cNNLdiFuww3XrIWcFfvhp5fz0kTm55I8lpK69YoZKYucJ0uXmecrV42uaSkYv/+MpzCjpsJGOJZAd+SlvB8l49OjUA6aS7aYSMQPAHeHWjiQrUhbThUTProte6jlAsWV9PNpMeTV1/pA1I9ozUhLFgofsr5B3eNomUm/ALMLVdA9tZwrV10Mr6Xyihkgv5gObGQLccfCPIEJ3pyxAA72mn4Tc6ZzEnNeNj+igOQcq1ND4v8ZUG6NlfwWYz6m42vMqkJ6edzsoSM3QMKr9hm9DHQ2kWWEoOdgc1sALC/M0M1eIDlGSYraNYVj8pgueh2mNuM3rMnWJ/oAKh/dHUVEibZSEnCk3Pvd8PIKi71hFbX7O2tX22hZN+nnTrnC+ePsGBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(186003)(66476007)(86362001)(8936002)(66946007)(64756008)(66446008)(66556008)(316002)(91956017)(83380400001)(76116006)(38100700002)(2616005)(508600001)(6486002)(71200400001)(33656002)(54906003)(36756003)(6916009)(8676002)(122000001)(5660300002)(6512007)(53546011)(26005)(6506007)(38070700005)(2906002)(45980500001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ox7y3/9KerG67qP31GN2YYPvzILIVE/q1WGhbdE4QDzZfUBL/+73WXu1z89v?=
 =?us-ascii?Q?+HRjyuaaEDmuJSgagkXxsd0tcvp9zAFUU/7VMCHRtwSGE89FTqxnxN6r2sWI?=
 =?us-ascii?Q?uObdDqshCt3OmG9DJRu+N0Z+kSfZeRfyn0Hzw50uPt8OQqxVtbYxYqI6k4b4?=
 =?us-ascii?Q?e6mtR7Se2lxdZNKZpvTzXbneeSB6YIf0cOlLe6Gjt9mEkq8SJxBFQoSMsP7j?=
 =?us-ascii?Q?yI3No1i1OE1J61fnkRZQwHfWH9DhkeLP5SK5CZC/obEhaVgktRmBcDVXvNYD?=
 =?us-ascii?Q?5Rm9OJrfYwF3xuwAgQ89h2oR5OlN5qoDhUvvzfMk2kyWEkeygBpi2Ygvy/ko?=
 =?us-ascii?Q?P0Qc6C8guBxDskje/QR2YJMQtJrymUrRX6p48ReYRaqjKMTLqbbtHN9FoejM?=
 =?us-ascii?Q?F6kI3Aa2K4Mv5SqTzP9Vu2NVd8wpPDBk4Q9sSMahKwI7DslVwSJK41Sqm8Nz?=
 =?us-ascii?Q?FpvEC/RLw5YaGVcqMLIHAeWuBwbktByvfDUZp7HJoJ7LKBa68sIkHsfJtXvO?=
 =?us-ascii?Q?Cy3UhT7B0NGaO9Pbbie87K+i4+qpP2w73My40a2x7GF7EOh+umBNSidH6k1y?=
 =?us-ascii?Q?40rlN2SmCr/h7DXlB/4XpbJbu/Bii2zRY/2etuicSZ45fUKzGvMEbhIET7bj?=
 =?us-ascii?Q?qVYOnzCnBHB1DNJWBQ64dGGHPINqXnX1lN38p7afhSWigA+lTlTLi4Mz7hHA?=
 =?us-ascii?Q?srWlOiTn9UHiAvlsEMynu5uK17s/dEB/ntKJC+kidEDB63KsQ5zqq+oAYxSn?=
 =?us-ascii?Q?DvFr6+rFAqvIqIQRjgOpESYkb56yKeNWWqsF69ROhr7m3cp5AYvHXd9p6rG2?=
 =?us-ascii?Q?r0UwoCREtQbjVt1jwWu+kYmOiT2833b+ZfS0k3jPNDqReu1dLpHSn9Mhk0xL?=
 =?us-ascii?Q?qH/qdoweuPZFem11Amh7aPfquO8gNBvsikXIH+k8pG+mTzIefbZn+XrHQ8eU?=
 =?us-ascii?Q?U6Pc3damg8BM4Tb2DCxy5Je9OILHb12yWD2xzuy9Ar+4ogo7UOtI8Ex1BRkz?=
 =?us-ascii?Q?1XYsYNZMthnU4uUqGt/GsFv99PP/WBfdpCzX6/0WYFgr5N43Xxdz71rVdm/E?=
 =?us-ascii?Q?QxMokdhmYtAAw+JBNN2/2nxaeMcJ5znz3+8uS7foWELTYLIykyoJTqARt5XG?=
 =?us-ascii?Q?hWsQDT3DV+VmAClFt6p40qTUs19cBVByWC5C0jVyvVgTZlmmFhkKarj6zbSe?=
 =?us-ascii?Q?L3lT16PjKgxjVPEjM8owp6E53A+icBAydRrB/ZcQHMwxjs4BY1RGRTVqhM4e?=
 =?us-ascii?Q?JBi4JqOSykfuUcnMHc99LCcZAJmvZlR/IB2z1Vh9rMe1ve1EUoGjBstqvH+S?=
 =?us-ascii?Q?mVoV98uvTATUspoHt45My/MYCaabj0mHmlrINBTBESREQ17FyGLhtQXWt9cd?=
 =?us-ascii?Q?2pOlWgf3g6g0LwaJiVUQozrYfw+wWX38XBAH2wGlUPf62nbUrjF+Z4UPLtIp?=
 =?us-ascii?Q?SW0nOuwUO2oxdtRK/N0JKjHOUAoGyuHjNcaPygs2FqLUl5XEHl4UA9xGJIVH?=
 =?us-ascii?Q?yDa3YrJmSt8LOYZ8ILUkNHPVFkms6+0G6gVcCpwZnW5F3JOYriM/5E6oSR+e?=
 =?us-ascii?Q?VEEJixfWV0NL9NAVuXZQ0kLq0I0wfg4nUrlFHE/NXT4K8Luv0NQD55vkxhU9?=
 =?us-ascii?Q?hw+QltYdG1YL2NuLHNlUNNgCh+Ck/RWFq1lpA6tjlV6uW6a0M2dNcLOQUImR?=
 =?us-ascii?Q?kY+aTad/1SBjTOSz0GuTeLkuHnTu+I3XIcwfq+g8TRY6WkAqjd/kOhihKr2k?=
 =?us-ascii?Q?vLi0pWFPJEQnYgE6WYM/9FsqznU4ySs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DA6DBE66ACB9E44900670AB5734C71E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f10cade-337c-4840-7b03-08da482e724d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 02:35:54.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gk3l3CfJdbHJHKWFjueGuPOvZYyigp7JlCD1nOq7ROXE2L5CbDaBoUQ+jNg8R/DZ3KUN0zOHazhgh5Bojg/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3030
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_07:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070009
X-Proofpoint-ORIG-GUID: RJKMIDVTQj0qJ3v2x0Oyset-BDr-C6bN
X-Proofpoint-GUID: RJKMIDVTQj0qJ3v2x0Oyset-BDr-C6bN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 6, 2022, at 8:59 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 07 Jun 2022, J. Bruce Fields wrote:
>> On Sun, Jun 05, 2022 at 03:58:25PM -0400, Chuck Lever wrote:
>>> I found that NFSD's new NFSv3 READDIRPLUS XDR encoder was screwing up
>>> right at the end of the page array. xdr_get_next_encode_buffer() does
>>> not compute the value of xdr->end correctly:
>>>=20
>>> * The check to see if we're on the final available page in xdr->buf
>>>   needs to account for the space consumed by @nbytes.
>>>=20
>>> * The new xdr->end value needs to account for the portion of @nbytes
>>>   that is to be encoded into the previous buffer.
>>>=20
>>> Fixes: 2825a7f90753 ("nfsd4: allow encoding across page boundaries")
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> net/sunrpc/xdr.c |    6 +++++-
>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>>> index df194cc07035..b57cf9df4de8 100644
>>> --- a/net/sunrpc/xdr.c
>>> +++ b/net/sunrpc/xdr.c
>>> @@ -979,7 +979,11 @@ static __be32 *xdr_get_next_encode_buffer(struct x=
dr_stream *xdr,
>>> 	 */
>>> 	xdr->p =3D (void *)p + frag2bytes;
>>> 	space_left =3D xdr->buf->buflen - xdr->buf->len;
>>> -	xdr->end =3D (void *)p + min_t(int, space_left, PAGE_SIZE);
>>> +	if (space_left - nbytes >=3D PAGE_SIZE)
>>> +		xdr->end =3D (void *)p + PAGE_SIZE;
>>> +	else
>>> +		xdr->end =3D (void *)p + space_left - frag1bytes;
>>> +
>>=20
>> I think that's right.
>=20
> I think I agree.
>=20
>>=20
>> Couldn't you just make that
>>=20
>>=20
>> -	xdr->end =3D (void *)p + min_t(int, space_left, PAGE_SIZE);
>> +	xdr->end =3D (void *)p + min_t(int, space_left - nbytes, PAGE_SIZE);
>=20
> I don't think that is the same.
> When space_left is small, this results in "p + space_left - nbytes" but
> the one we both this is right results in  "p + space_left - frag1bytes".

Exactly.


> I'm going to suggest a more radical change.
> Let's start off with=20
>=20
>   int space_avail =3D xdr->buf->buflen - xdr->buf->len;
>=20
> In this function we sometime care about space before we consume any, and
> something care about space after we consume some.  "space_left" sounds
> more like the latter.  "space_avail" sounds more like the former.
> Current space_left is assigned to the former, which I find confused.
>=20
> Then the second "if" which Bruce highlighted becomes
>=20
>   if (nbytes > space_avail)
>          goto out_overflow;
>=20
> which is obviously correct.

IIUC, it's correct only if space_avail is an unsigned integer type.
Otherwise, comparison of space_avail with a size_t will cause it
to get converted to an unsigned integer, risking an underflow.

I've toyed with the idea of changing all of these signed integer
local variables to size_t, since they are used for pointer
arithmetic. Bruce has taught me to be wary about that kind of
change, however.


> We then assign frag{1,2}bytes and have another chunk of code that looks
> wrong to me.  I'd like
>=20
>   if (xdr->iov) {
> 	xdr->iov->iov_len +=3D frag1bytes;
> 	xdr->iov =3D NULL;
>   } else {
>        xdr->buf->page_len +=3D frag1bytes;
>        xdr->page_ptr++;
>   }
>=20
> Note that this changes the code NOT to increment pagE_ptr if iov was not
> NULL.  I cannot see how it would be correct to do that.  Presumably this
> code is never called with iov !=3D NULL ???

That strikes me as a good change. I will add it to this series as
another patch.

Yes, this code is called by the server's READDIR encoder with iov =3D NULL.
See nfsd3_init_dirlist_pages().


> Now I want to rearrange the assignments at the end:
>=20
> 	xdr->p =3D (void *)p + frag2bytes;
> 	xdr->buf->page_len +=3D frag2bytes;
> 	xdr->buf->len +=3D nbytes;
> 	space_left =3D xdr->buf->buflen - xdr->buf->len;
> 	xdr->end =3D (void *)xdr->p + min_t(int, space_left, PAGE_SIZE);
>=20
> Note that the last line "xdr->p" in place of "p".
> We still have "space_left", but it now is the space that is left
> after we have consumed some.
>=20
> Possibly the space_left line could be
>=20
>       space_left -=3D nbytes;

This part of the code can become too clever by half very quickly.
Since this function is called infrequently, we can afford to err
on the side of easy readability. The way it is after my patch seems
straightforward to me, but I will keep your suggestion in mind.


> NeilBrown
>=20
>>=20
>> ?
>>=20
>> (Note we know space_left >=3D nbytes from the second "if" of this
>> function.)
>>=20
>> No strong opinion either way, really, I just wonder if I'm missing
>> something.
>>=20
>> --b.
>>=20
>>> 	xdr->buf->page_len +=3D frag2bytes;
>>> 	xdr->buf->len +=3D nbytes;
>>> 	return p;
>>>=20
>>=20

--
Chuck Lever



