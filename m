Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C177632C6AA
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451087AbhCDA3t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58288 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352090AbhCCSn3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 13:43:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123IP8GU127801;
        Wed, 3 Mar 2021 18:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eNZuWh31TLwPWvaODuG3eEQQGCOicZdfuDj8fY9nL7k=;
 b=Q8dS9SZ2cqUjiZrcz9ZsBPTy3o/aG65f0ErElID9CH292IW3vwfD9ul4OR13VWKQ75kZ
 D44I5KLyqNLaK0I0iGHXqpEiMIDEo+Vvz1reCTmA5e0eDH65J7MIla4cW119+GjJZh1w
 dSMC0q3wbyj2s8n58H5lvdNm+eHjkwJnw2CqHZQk9DPGLHO7mjj+ByWu8W9oXFEHKWKp
 TklxINVW9/vBA+3MZUhdHycto3P8e5I8TuCsFrOux0y/nmEKCaifnIQ0a7gd8UHE4odR
 HIgKKvqRpjyZ7MjfG8qppo4N3/eZ77znFzO5Q5aA7yxAMNnNhGvBvgpsOEmSURIcWU5V wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36ybkbcnem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:42:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123IP6xn156904;
        Wed, 3 Mar 2021 18:42:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 370001nane-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQC+Ob4qB61VDeo+COxMX8kOcxU9qXbpmpRcPWzkudu+vpUqmUPP021QRqyaMt7ZyZHjvYqqEIVM/oouy3qfN1vOi7Ca/dNBhwwcN5Yrp4sicDAzAKReu/43W54RfhZX8RmYdY4DhZ9Byfs+9nopZKVJrmNv8wQgGMqlLPfBSv51rCRkeQCLXF0EuePYlFdSsCfs7R+84L3MErYNBKNVRMVCiUQiB18n6+9F4LgFEMHZFNgj/DVOygNagc7tiJcG8c6dPm8JB/h/J9CQveWrdh8eTjEvue7ck3puEiBzciPC1W7jpRXh3FDhIXxBlDlwYLj6DFjO2dxKzsRdaGyI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNZuWh31TLwPWvaODuG3eEQQGCOicZdfuDj8fY9nL7k=;
 b=VZ3Hl81KnE3IZpuISm/Umj8YyX9mfXJiN+Gbv3/gAM/POJHz8z9iz/DfgjRYRvt5QUBbExv8vZYzm9x9m1UxEWLLW9lnu6VFBdC5zxgodnb5QtuzGeYjbgr+SoRUIHjrFNPKunZYcktF5c7Kg9ToTnCX0C6EO9Dta0LV/kxHRy2mR1KS12vRv3avge9S2dijFlWKwalsEgbQqTvChlbYeh88ebiSgy10VoKhlHG3JKE0bdBFCpNVBo4bYIgA7TG+rYjhDSGXkAcBrR5MTQijqI0eiIxTwn8YL2uabB9D05Nzs3aLW2EkV41zqO/WhUXOe0jEYsQ3D8+HiE3Yb5nygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNZuWh31TLwPWvaODuG3eEQQGCOicZdfuDj8fY9nL7k=;
 b=Dl0P/AtI4AwSeqSG6tw91DbmWne589KXOAySTdUxLCmpOeIe0tpERgUbVrG4R9g1HnaYzyffcd5feyHCgv/ITIjMe4sdehwhTXjHicM63eImElwfVP14LcRJn/qvReg35/EsooJJxbhm7DBKvvNAjc5sopzs7lRulFfQJAfDNcA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2710.namprd10.prod.outlook.com (2603:10b6:a02:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 18:42:33 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 18:42:33 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Topic: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Index: AQHXDq5E9L4cYzCeI0iQSySXwa3yeapxRKEAgAEl6oCAABNjgIAAGDkAgAABvQCAAACYgIAAAMaAgAACKYCAAAEqgA==
Date:   Wed, 3 Mar 2021 18:42:33 +0000
Message-ID: <E7444E65-60CE-4BB5-BED1-216F1D77C9AD@oracle.com>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461183307.8508.17196295994390119297.stgit@klimt.1015granger.net>
 <20210302221130.GG3400@fieldses.org>
 <592A34CB-C178-4272-8905-F3BA95BCE299@oracle.com>
 <20210303165251.GB1282@fieldses.org>
 <D8625219-C758-44C0-A74E-272019E12C2E@oracle.com>
 <20210303182546.GC1282@fieldses.org>
 <FB4626C1-C2C1-4927-971B-8937420F963A@oracle.com>
 <0908A838-D518-4F81-B6EA-8C088D5538E9@oracle.com>
 <20210303183823.GD1282@fieldses.org>
In-Reply-To: <20210303183823.GD1282@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4fd6b21-64f7-4eef-c790-08d8de741bd4
x-ms-traffictypediagnostic: BYAPR10MB2710:
x-microsoft-antispam-prvs: <BYAPR10MB2710174A13DE9861598623E393989@BYAPR10MB2710.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXUv3DU/4uDN2iulVQJRoHGSZN9h7nPRC+ZprYbe0HjCjuWfIYL4lXBL4VjN8BeIeObCWwSUOISrv2SUlYH8M/3mNiywC0SDxAnZuKHvRwO1kkm55RMLQEnLANm9G37+QzjlnW763bNxKo3EgOb/ZCW9SCgIgOMQRq0vfLaIHFHrVLBa+5rrIgcGn98031f6EoRnBuZhCxdtAAtmZ2JfusNMoA29Yppvh60sNAGTgl5i9f2imR+kzd9exAsUpmTavzr7vBzinn6HvNaEF55PINoI9+a7bUkjjYKTOmj+V8D1rIT46i3UuiWOrCHTtcxj2IpCPIiUTyZGz82qsX5erzJAVco8aEkoufhDPnE3I+CeZmtyWVklsvWoz2VwbkEJQj2B3ALG+NsE3VuxhbvZypKu8wzBd1ef8KzAnBaWLPXDOwOWj9HuJB8WBCcvOBBAQ02MHYQPvc2+XiDdXAszvl2h4Zk1J1+Ilj80ggw7xqbN/cmWKkpyefi3D7E/RKmi1WznzveWJs8IgQMyJ0tUgUu/cqkyyOPdDZZfGrIZZ2YBoMHxjbi5fINftIqp6ij0vIit5RHUzqWRNuhr2pWUrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(136003)(346002)(39860400002)(6486002)(6512007)(2616005)(8936002)(44832011)(66556008)(66476007)(66446008)(64756008)(6916009)(36756003)(26005)(186003)(76116006)(8676002)(91956017)(66946007)(316002)(86362001)(53546011)(33656002)(71200400001)(6506007)(5660300002)(2906002)(4326008)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hBT95kt7IufUGUhgXPVIjuroueHuuwoC1RSkQgJwsVBEMJa1CqQ+UDb86hJF?=
 =?us-ascii?Q?u7bYuPqkYV0JczpVPOyfXXw+fOHzdCg57tBLjuljgAMcTiSEZ71xQUNXTX4e?=
 =?us-ascii?Q?dmR/Z64fcka34I+6aXDWoeUVXR8jmW0aeBVhYkd/1SE3f+eH1KCQoshHcNFM?=
 =?us-ascii?Q?+Wq5JhCVqEO98TH1w44P85eY3ZQ+unXkREvtCwDJGpQic8z4VVzSnq2c+G8Z?=
 =?us-ascii?Q?lFEsVnqAjNc24mZd9tfH8L1jBL6NIWLQzyRc4OUV2YKWl3SirC2R3/xCq9Jf?=
 =?us-ascii?Q?sdA5c/NYZ9+FiQPDprhXO+qWZnw4DLvpacssLwzASGgB2HU94M1NwSJ3tpl7?=
 =?us-ascii?Q?a0s1qa4o5Z3XacqiVjeSUHdFWfqJYYYbSOOh4qTH9FP+c6WTLNhZ5LYlJ6IR?=
 =?us-ascii?Q?YWzd7U5d+0EUC+DpiBUwKUDR6BbnekxtmnplBg1FcPLZ6CyNkFFuKDQ7TYSz?=
 =?us-ascii?Q?SAn0dIil8IMIjUvLq8MZVWL/eR3hiERssZjR4O7Xm/bKY/HHdoK42xM1PyU2?=
 =?us-ascii?Q?WonYi2J/YypTuPGndxItlZXQuGmFZp1R2OeWtEkshj4NHEtwXKKTCy2ck55j?=
 =?us-ascii?Q?Nk5BTFOvBsSDviSHfRgcCMptJeCgaF3zjJnZKZFP28zxeGAL1KYNtqwvl3YC?=
 =?us-ascii?Q?xSzIKjSzgfXjV7qbLicnGtskwg8UvNUqHUfmQP6DCj7pX3O7GHELQ2PVLu5X?=
 =?us-ascii?Q?Lt4t3i7XRK+anxOuJ1PQyU7l7JPV4hrSQ2ZNFJPtR8RFtDZ7/WUUZ39VXukw?=
 =?us-ascii?Q?F4D128DbqhxetzUmqYihM74Nrb8lMvB+eE+mgSal/ZwAoQLMtlBSno0IOgto?=
 =?us-ascii?Q?uw269ElZ/m/6VZOhE2/MDADLTgoalc/NTMNnT02jj5U/VTbIEdcwfhWo8Qkr?=
 =?us-ascii?Q?FeyfLQtbfwqxpSDB5HajW4FR+J0+uLGF2pBTuT0SrejjCZnjQXRxr5dQnFv3?=
 =?us-ascii?Q?JBlGKL2+FxkFGcZ9+muOjbPJSiLMl8MFYQ4fhxmSPQgn/aSHsXdmLX7wSNsX?=
 =?us-ascii?Q?bxYQXXH5YSJqruEtL0SvMmRXE8Y4bLRTerAl78W1jOOzSuBL6TE1O9lm40io?=
 =?us-ascii?Q?9is3aBi/0pVOatVZlAnJ+82QHo2RHkxSVhYbL/OkNwdFzTvJoXAPVUWQnt8r?=
 =?us-ascii?Q?PXQO7x1GXVXrRUFdQbDcuwG57ttcIymtqfEgbIArNi6HenH69OyLRCGzh7UQ?=
 =?us-ascii?Q?phqQu3MfAwwRz8F7nm3iNRezvIbn5aUhuC/NNhlV3TPLgb26bdiTFTZvmtTb?=
 =?us-ascii?Q?bNTnOD0P6oEWnnT0N9iop2/X3VfRxoUxXc9YcVEGyG6OaqGS/FzXJRVGZywE?=
 =?us-ascii?Q?y9y/pGdobN9p0oMDN0vZHEqlGxu2vGh33S+ts/8BfNhIaA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39F71FAA1D956540B101D15D0D4C56D6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fd6b21-64f7-4eef-c790-08d8de741bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 18:42:33.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1vSwr7OiHmjqhEVE+k7G7EKO+L08AUKpTOdIni8Z3ZB2LxjNlM4eBTg89vtOnfzhDHEsuMLaojSV2HbehQUkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2710
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030129
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 3, 2021, at 1:38 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Wed, Mar 03, 2021 at 06:30:40PM +0000, Chuck Lever wrote:
>>=20
>>=20
>>> On Mar 3, 2021, at 1:27 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Mar 3, 2021, at 1:25 PM, Bruce Fields <bfields@fieldses.org> wrote:
>>>>=20
>>>> On Wed, Mar 03, 2021 at 06:19:33PM +0000, Chuck Lever wrote:
>>>>>=20
>>>>>=20
>>>>>> On Mar 3, 2021, at 11:52 AM, Bruce Fields <bfields@fieldses.org> wro=
te:
>>>>>>=20
>>>>>> On Wed, Mar 03, 2021 at 03:43:28PM +0000, Chuck Lever wrote:
>>>>>>> Why would that not be OK? the next call to xdr_get_next_encode_buff=
er()
>>>>>>> should do the right thing and bounce the new encoded data from the
>>>>>>> next page into this one again.
>>>>>>>=20
>>>>>>> So far I have not encountered any problems. Would such a problem sh=
ow
>>>>>>> up with some frequency under normal use, or would it be especially
>>>>>>> subtle?
>>>>>>=20
>>>>>> I mainly just want to make sure we've got a coherent idea what this =
code
>>>>>> is doing....
>>>>>=20
>>>>> Agreed, that's a good thing.
>>>>=20
>>>> I'm also a little vague on what exactly the problem is you're running
>>>> into.  (Probably because I haven't really looked at the v3 readdir
>>>> encoding.)
>>>>=20
>>>> Is it approaching the end of a page, or is it running out of buflen?
>>>> How exactly does it fail?
>>>=20
>>> I don't recall exactly, it was a late last summer when I wrote all thes=
e.
>>>=20
>>> Approaching the end of a page, IIRC, the unpatched code would leave
>>> a gap in the directory entry stream.
>>=20
>> Well, when I converted the entry encoders to use xdr_stream, it would
>> have a problem around the end of a page. The existing encoders are
>> open-coded to deal with this case.
>=20
> We're not seeing v4 readdir bugs, though, I wonder what's different?

It's a small patch, easy to revert and find out with your own preferred
tests.


--
Chuck Lever



