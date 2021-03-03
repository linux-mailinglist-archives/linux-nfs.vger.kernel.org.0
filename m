Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB9E32C6A2
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449436AbhCDA3m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33138 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378968AbhCCS2k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 13:28:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123IP7jD011461;
        Wed, 3 Mar 2021 18:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MsHbBalW9zYYA8Pl8dcNsCBYVZLSQ8D9AhewCkvG5BI=;
 b=FjcYVdO8MbDoT0O90bfNsA+Zjl5EVgVh2zVYJooI6QHVCC79lMwVTjWlLhzmIKY3uh0w
 PZ8O1tHzwLkxf6pOa7yzNUClgKs9mN413ssLK5VCz2MV7UC8NXX9S7Fzcc/6r/ozv8bh
 JWwINpFRUKWGjAax/BoxL/AtXH8TVcUCbrrWTo39hSlr741K8Aq771AAl5BscYarMTEb
 YDuZvyepnsjwjBJBb17+/EntyOfqj6JCpcXRF4TZLb7gsAxZnplTRhJk9utbCGT4pzTe
 LkSYTwm8DQ9n6a25nuL9Jt6q7ACIkoMv2YsY6Dfm5TMR5S/2+ylSled5xs9RcPnDRsnf dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36yeqn4e6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:27:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123IP5pL156770;
        Wed, 3 Mar 2021 18:27:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3020.oracle.com with ESMTP id 370001mtga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyURS/b0VQpjzJYSxHKSBDxQqSZ4lOiqag2uiH33szVgFMIHyHCRsR4Q9gfJtLe0/E8zcd+kPEGpLrANA5n5ZTzC/n/pLRwnoKeGGUFylr7ukdUpld3ihbUgurpeA1Qbcy6CVb+83Oog+703ol9z8LqsIMkeCAt2Pt7NtEhYRZTMEYqZNYbIGnCqoN/dQ1wh4r5X0dwgF4PQJO5RV78nJDLFX5E/MXG3/ou57AJhVRFyNeYGmFyXQCr1MenGsLO5VoHl/GtsNuwXR5XpNDvmh4yvTGUjtOqmSliyrPG+DGogdQ66nRRUV/eI1pvGq4SYwDerRmfGa6Sgq8UxcDgQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsHbBalW9zYYA8Pl8dcNsCBYVZLSQ8D9AhewCkvG5BI=;
 b=Q1Cg7uKJW1XCsftVQUu6zLun9Y8d1ubRQ4YVkHTXtd0ErNJZZhwlgFampXYE/RuNnMHpmkp5Ia5K+8xLOOExWm3XtnwJ4vhqbHxfRz8pMpgRLU8sP65Sy4ySQGYGDI7K2XZVg9n4uWwiE2xzsS1kmUptM86xVcob9hDw54+96q1xFIWEFLuFpXp87/0w9RMUtYx9b6IBCUza6hIZIXGeYNkrlo6xtSRw9IuTI8WC5+gplSzPPntUYmNvKT2n/Iuq/TEx/ychy9MNg5d9byP1hEfQfpUbZQdpXFICaoN36YWDjm1NiM8P5CIHhOrT3DEZPBVU2p/1/BY0SoChtEVUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsHbBalW9zYYA8Pl8dcNsCBYVZLSQ8D9AhewCkvG5BI=;
 b=li3t+imatYR7oL7CXuuoZUifugshGn17lwA/WO/pzFyhTSObC3SdGvmgXpWfhgkZSroTkqSIz00URZhuuTANFhSoTmuQQyrhuYAv/xobVr4Svc7RF2Jmc0wdrISvSXrg4vfjiUcb8EmMxFyXM6/9ARbV1NcVPvP3NMcT3GA4yvI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2439.namprd10.prod.outlook.com (2603:10b6:a02:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 18:27:54 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 18:27:54 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Topic: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Index: AQHXDq5E9L4cYzCeI0iQSySXwa3yeapxRKEAgAEl6oCAABNjgIAAGDkAgAABvQCAAACYgA==
Date:   Wed, 3 Mar 2021 18:27:54 +0000
Message-ID: <FB4626C1-C2C1-4927-971B-8937420F963A@oracle.com>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461183307.8508.17196295994390119297.stgit@klimt.1015granger.net>
 <20210302221130.GG3400@fieldses.org>
 <592A34CB-C178-4272-8905-F3BA95BCE299@oracle.com>
 <20210303165251.GB1282@fieldses.org>
 <D8625219-C758-44C0-A74E-272019E12C2E@oracle.com>
 <20210303182546.GC1282@fieldses.org>
In-Reply-To: <20210303182546.GC1282@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10f9460d-59df-4aca-837b-08d8de720fcd
x-ms-traffictypediagnostic: BYAPR10MB2439:
x-microsoft-antispam-prvs: <BYAPR10MB24390EEB4E6A6EF48C0DA5F293989@BYAPR10MB2439.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L3/XVmLJfwvygLNogyUKRR2MILcVUdurQzjVtNXd9vc0zXDJMU7V2+1Go8Yqvx23zLxHFE0fcbyIW+g1PWQtqN0DeT1L0ZBxTyCq6iriU7kXMz2HCOETTl0J7iJMQvRevxN+pHbrwvtIcssbzCPpNhIH8aKjR+JYBbUYwUXiL1arBmGcfaO4wasFQzWHl1qfHEAVy6jwQsLW2RkHIkIVJIRZQ2RODXLHlGyJy8Z1TopXdNFKpkHs0dsQG4giyAtkXfi6404QPpaeVneNPg7COsflRMWOqMhqyWNDz4+z0vIf1kmyNwdS3KGldD9obaNkH3zNotWQAVedl4faHbu9U7PhKrsKxWWAonmcwbMNPmfD2I4U6SBMMioUm/flETtOJCqlLX3vhXUVZ2PcblSftRQ5lGK1Q2eIbWQoWfvkP4ucVCUwy9oV2rQ+r/E32opXBXa9Ilv6sL0sLNC8EPut+MqSTltfXX7jeTskzvfX6K21GlTP3kSWTv4KkpwVNOzPqkHR2Y2KiXVeqgsSkUbXUTaP0nVfvCLuy1vt2xdpqebT11DSBTP6ILqvrRf5f0guDdgp9uyx9CrG39Dx+HOGmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(86362001)(478600001)(66556008)(71200400001)(36756003)(53546011)(6486002)(6506007)(4326008)(8936002)(44832011)(2616005)(6916009)(33656002)(316002)(2906002)(6512007)(186003)(26005)(5660300002)(91956017)(76116006)(66946007)(66476007)(64756008)(66446008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QX0M5SmJSiLQJINVb9Tlsi4b+N5KTNcVvkmg591pPL+v+9J8VhjO+54+KJsT?=
 =?us-ascii?Q?H4xHgF9UA/Pilf16kvolVLEozieOdaErpRKT1rsbV2a4R4PnnoIKK9zAkoIs?=
 =?us-ascii?Q?jElEQvqI3Vbirqy0QTT6DfuuO40TGD/peXf7UTkX9wvn2werEU3wYGn7dHlZ?=
 =?us-ascii?Q?4LPtSOtRI7E8S/qclzfTHKlzmLeRAnVzK1APsv+pVj3iqsh3ieDtjXE1Z4kZ?=
 =?us-ascii?Q?mkU/aNm4UPYKh82r1tu4SjOSqznptB+1h9YviTOoRtI6Q8+xeb+0LUpFcFJN?=
 =?us-ascii?Q?ObK/N6eaLXAbJ6mKBgGCA84CuALGN5mIKrzAOtgzr/Z4wYtw303NtqDwiOxo?=
 =?us-ascii?Q?q8XiCfppo14rr6MA3J0RUfhXlmNgfDvaPA75jEnW0DFs4WpIN/ALPqmvdX1Y?=
 =?us-ascii?Q?sqD8X4YeuDD2KQrL3zXI3aCFYv4/nbqIMSUnfLgBZLiOoze8Q8YG+yW0NsXH?=
 =?us-ascii?Q?HU5jS1qhMdMqpXHuyVzJE/c26SCD7sXo3ZhbcnLNVHeCCOlDt7oKnXsSgXH4?=
 =?us-ascii?Q?ILdPcP6VYgLgBDkjRXnCKFyYtCEPEDUsO7qWc1BjzepUaAAd9U8U449tQIXB?=
 =?us-ascii?Q?BGni0dMpqfE5vSgmTl0u/oNC0YU/zIkRv23CeZQ/67t+30tzr/7zcD2BZdOq?=
 =?us-ascii?Q?P4MSnDn2YbKNEBNevnNnP1gaQWFm2+jBEduQ2VWd35L0gzySiw9Ip+wNS7h6?=
 =?us-ascii?Q?z1znhByoBJKcD66GOqlTXAblzwS/fmUq7kugq5rqfg4ycmvcijjHhjSBYjHd?=
 =?us-ascii?Q?2RvNpdgsWw5n7us8seC6VF44xScKhMaApYgMGvccCQcamiLKSpUZi5L0Klro?=
 =?us-ascii?Q?J5Og5ZFpnA+wVK5spfJqeover4t5+79nwSQPRFvdR9ly1wAVEsaMtMtpiRzf?=
 =?us-ascii?Q?CiDY3wNYB0nOZYylbJHiKlhj3/Tkt3W+GwK1SkcQaQ7lG1/2YYnAvXQr4hrm?=
 =?us-ascii?Q?1VEwVe4/2vJIVSjbukZq8lIbC/5C5BY1UjOMhTodgKGdm5IoHykKIWRihhfK?=
 =?us-ascii?Q?w/EWfOZ6M82yOtlEuqomkoFSbdb/b59FumzL4wEKOimT4IvhRTPzgaCYQ2e2?=
 =?us-ascii?Q?exi5pP3i0uxtJ1KhtAZV5ZBE1lprPqOokLzBY8HhM9pcxzUZqSp+jO22VRj7?=
 =?us-ascii?Q?YgOpp2gXCO9aSZHQXkqIHg5d2Qk6fLCH/mynrzVIk9PNMOtQqYbqYiujmGBF?=
 =?us-ascii?Q?tofAeIzeiesvZ6PHimDUvFAJgc1K+DUQ5E7Z5pCl8diHaaWmHjKX86g6HSyp?=
 =?us-ascii?Q?Ip9hB7auUx1h9DI/TIDiPLiwl8LlbtRoEVev543aiDmQ2P8W13YW/HtExlE7?=
 =?us-ascii?Q?CV4QLAFuYnZFOgR6CjkCp3XlHssmhQQO22yXEVwuiVA2pg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <86FC6FE73920B54E9881191E9BB322E4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f9460d-59df-4aca-837b-08d8de720fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 18:27:54.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgupNYi49KT7KfYbMnqLGz2wAEX+OHulVfbrWus7QZQy+qzEt6+GQ8UlfboXKx/d7onXLEnY6J/A36dZTzdK9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2439
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030129
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 3, 2021, at 1:25 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Wed, Mar 03, 2021 at 06:19:33PM +0000, Chuck Lever wrote:
>>=20
>>=20
>>> On Mar 3, 2021, at 11:52 AM, Bruce Fields <bfields@fieldses.org> wrote:
>>>=20
>>> On Wed, Mar 03, 2021 at 03:43:28PM +0000, Chuck Lever wrote:
>>>> Why would that not be OK? the next call to xdr_get_next_encode_buffer(=
)
>>>> should do the right thing and bounce the new encoded data from the
>>>> next page into this one again.
>>>>=20
>>>> So far I have not encountered any problems. Would such a problem show
>>>> up with some frequency under normal use, or would it be especially
>>>> subtle?
>>>=20
>>> I mainly just want to make sure we've got a coherent idea what this cod=
e
>>> is doing....
>>=20
>> Agreed, that's a good thing.
>=20
> I'm also a little vague on what exactly the problem is you're running
> into.  (Probably because I haven't really looked at the v3 readdir
> encoding.)
>=20
> Is it approaching the end of a page, or is it running out of buflen?
> How exactly does it fail?

I don't recall exactly, it was a late last summer when I wrote all these.

Approaching the end of a page, IIRC, the unpatched code would leave
a gap in the directory entry stream.


> --b.
>=20
>>=20
>>=20
>>> For testing: large replies that aren't just read data are readdir and
>>> getacl.  So reading large directories with lots of variably-named files
>>> might be good. Also pynfs could easily send a single compound with lots
>>> of variable-sized reads, that might be interesting.
>>=20
>> I've run the full git regression suite over NFSv3 many many times with
>> this patch applied. That includes unpacking via tar, a full build from
>> scratch, and then running thousands of individual tests.
>>=20
>> So that doesn't exercise a particular corner case, but it does reflect
>> a broad variety of directory operations.
>>=20
>>=20
>>> Constructing a compound that will result in xdr_reserve_space calls tha=
t
>>> exactly hit the various corner cases may be hard.  But maybe if we just
>>> send a bunch of compounds that vary over some range we can still
>>> guarantee hitting those cases.
>>>=20
>>> --b.
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



