Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE93FBD77
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 22:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhH3UjF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 16:39:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31280 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhH3UjE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 16:39:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UKIkKO032697;
        Mon, 30 Aug 2021 20:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z9tkbOgMZ/ddlr9MA0d1Vcm3ZkDO7PuT3zZ2b9ERLtY=;
 b=VSDoOrxw9sqFQQPfNzJawzaQXGPKCIJ6EO96wjX15gBzJPSyqQ9cmydUajATo4O4T4xy
 o2QxxrLC8+1tNKkx8e5XBaMnSCjSa+St+CoQs56W9Wv7ml88E+Ld78lJXI4pK7wzCTGj
 f6qVFPDPj0Cfm/W1eV2J0t9Ox4v/K2gJLNx++CwL0X5yGgiOPRJ5gYwseB0Tmla5MM+j
 PhS/CKYF1nadzqkfwu7MmUmh1l4dVvHJi84yUuUoFPt2nR7cEtZCCetgUN+43Cn/UwdQ
 mQLk1SaUVlyXlmTJw+f1holX2khCjqLQ0QrLcBkIsCQ2J+5vxDHN0h6v27l3bjq4LHRP QA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=z9tkbOgMZ/ddlr9MA0d1Vcm3ZkDO7PuT3zZ2b9ERLtY=;
 b=BW1K0HfdyfZ9vy/UBWfjdsO0XSurO+C+/PU/I35S+69M/zR6dySdvTstHWbzybBnCJeN
 Z8nht4GVr/ZxGHLHBzdZaXqv1/HMmjd3/T6XrnKQicgomezcS93LYbwYNg/p8FcXWgo/
 +Sg836wVENB+COe0n0058B0ClcIKrL/tPs7N4AtkXh0QsuLP7AfHb6pvbQ6QFzt43o8K
 RUShk3+sTkFtoIjrXRgP8oFu37kGoKLlQohlgawDv6xniQrV1HvMuZnelaJS32GJpGhL
 kR+Q9TwA14INWUUo76r6f/zAWwjw1Ep67yjTx/bFQ0cWYHLoYrXTl3vc0PM0pnHoi5WK hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxsjkq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 20:38:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UKZieg152108;
        Mon, 30 Aug 2021 20:38:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 3aqb6cjhnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 20:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRwA0yKht9rzmdOnQf4XPQYovhLckg+CYcQz7R+dZuTJyp7qQpaqL7TjmJYXx9n/7/thk6IGFLRx4/iGRPLcoATcC9kEHsPlwZyk7G5Hua6pakLS/6qtieGL+h7w/lqTU6MwdesOKtkE8YM8ZL2ZX88D0DQcEdnODfupauhuVZHiobzYtVAL4cKaJfYw1W3AGhMs1e18ou8nFVbvhTqx/DK5Qx9J1IhIKgrU8TWzEOi0x348rBMKVginYkwmoAnQJG4lyhNT3nqhh3MCUTCQC7lPb9fBwCK52j16il+JyLOF9cRiBr3iEcOI2gzIyis09B8zInhftSxDqXgCIzCVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9tkbOgMZ/ddlr9MA0d1Vcm3ZkDO7PuT3zZ2b9ERLtY=;
 b=iEGxu+gy08z35nnJTTxjxn5cCPTS6/lp06hWF4jC0Gv9HODDuOfiFnszQq4h25HyIHEhkZdWhDWZTAmkJUmJcgjs09kzo/lpLkfMc4rQwMUvPEVeIIbINRRI/Xv1ag3zMUNNDUve9scXRa/WKOXAHWI2rn2BDNn9KHBrPCS1avoHwqUF+AkGWYZfGK8MPCjqTVM094tf97NixD50gi5BnK+6GAvlOjrNm+ehdnITC7126GFuL92vIMp9wAMWHuTNZUUl96EYomd5Jshne8eufLen371jGkUZZ7j4LtdiaXIz/dl7iWa6hMXAcxgv/8SFMsWf+9aruPBEd0jeLQGDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9tkbOgMZ/ddlr9MA0d1Vcm3ZkDO7PuT3zZ2b9ERLtY=;
 b=AcyC9J8Wbzl787qVcW8a3uz3BqUfPtwJApzoXNyCBSWf4QBhdjcYqmOrU4Y7jEw6WNk21bfBCPuUtXqsDn9qYxCjnI0tWRiSt6E5bymIJHP3ARWqY5KUaIG2I/PIEC5dZ4hOqoa49Kg94Qjd2wsyEXteeOdHkRxpuY3LlnzNRRI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3509.namprd10.prod.outlook.com (2603:10b6:a03:11f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 20:38:00 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 20:37:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Topic: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Index: AQHXnb+EPQ6bfsCh/km34j6ENph6pKuMRqKAgAAFyYCAAALCgIAAB7UAgAAEWwCAACcYgA==
Date:   Mon, 30 Aug 2021 20:37:58 +0000
Message-ID: <B5C7A8A1-E810-4616-9E1A-265BADEC5432@oracle.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com>
 <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
 <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
 <04f975f95126921f3d239a7a9d80ced2d88b05ff.camel@hammerspace.com>
 <C73DE4AF-9C1D-4694-839B-D88EABAA6DAC@oracle.com>
 <9448f294a39775734212083cbe329642b9e15d09.camel@hammerspace.com>
In-Reply-To: <9448f294a39775734212083cbe329642b9e15d09.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58e666c2-ab05-47bb-a0c5-08d96bf60dd7
x-ms-traffictypediagnostic: BYAPR10MB3509:
x-microsoft-antispam-prvs: <BYAPR10MB3509EB2EAF213E7B207E2FF293CB9@BYAPR10MB3509.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wNLnG9ZDwTh2bUjwX7iVvmiDjRAdlbc7qXlHw0lyQ+S+iEVWPQn29ek+oTVjGRSk4GMRLLFwtBqCKn0747pK70H44U8/NEG3GdwnwHwcWbg3jLwsiGSSlQl24AAAyJnkqfjes3QA73PV/C91RfFpDDHqjrax1FCsfwML2wDtHXp6TlUosGzmhqK9RKeA/H6QScdmaVijI7sxJUETjGpvlBtv8LxZn2O1C9S/86hDg8Hmjl38LwlKEv3Y6tjlW5chLGTnOJWQXyzkwGaz2NC7R6q+EB/vZWmROvYTL48TnPetzKdCp/rVgXGxvax1cMcms6X+dGQW+5heQCubUlKq2bE6M7ckDR0eDUy/hz1JItGi+YuO7nd1r75Ydp61bk9z/qJkPX6V/20luBmI/Od/JxmitOX45xjNpHOpSh7C2CYsu9z4ZuYOhgSL/jI1lIMJBAB+cMJJCAgQb6zcSmEX6UN7I7K+B0A50tCD7iLqBlAgr8aSxmcX/OzEVn9qXhOYnseF2+ijE3E1cGvSFqGkg6CW9MNCl6SfQsioXRis7e5WM+z0ZQhceqg2tO2jNZIdmmvu0WKA/BI+ju4Uhzyu7xNIOQFUswv5EiJw3fUzrNbIfH8XCBgXakZnj8+eNstCxy/+3aA+kPuXyVjlXOJr157VQbIZieKQiv2X4YRlfQKQU7EEGTG6nowkv/nzdfBuV2j+hhBbSBLXARPiJtGWwwiL6RtE4WSOp5YZ7+QRgXzVOeIIiV46zAToza6xj8N8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(136003)(39860400002)(122000001)(86362001)(6512007)(8676002)(2906002)(26005)(33656002)(66946007)(36756003)(54906003)(71200400001)(316002)(8936002)(4326008)(6486002)(6506007)(53546011)(66556008)(2616005)(83380400001)(38070700005)(91956017)(5660300002)(66476007)(6916009)(186003)(38100700002)(76116006)(478600001)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qrbRsf9rWrfVlpiX9wd1SqHSe7+OTTCxnWgWcFxzuWfyz5rfu0W1Gi0nP5Os?=
 =?us-ascii?Q?8nlpV7b6fW9aEtUwpH7QkuSyKpRezH0Lx6BDIBGlgeAVTqtw9qsxTiX+fF7T?=
 =?us-ascii?Q?wAyh1EXTXBwO4AtkBU9qrIY4pwMWlKb4qZUz9vDqo8pa2FLsi3nmdjiFhzLl?=
 =?us-ascii?Q?KjK/J5qk9dsUQJvImfw7yQF1ACPxtNv34++ZN4Uz0Oin6HwCaP3+MkMir6J8?=
 =?us-ascii?Q?p1GbuyVAZrRCTNWwhccNQtwfZLt8pL9KEEHBkRou9Ag6uqgjZVU1g32nmaUU?=
 =?us-ascii?Q?z2ghvSHf/P/FbTLkUBdC1rpzFCqqexzDDea4672HYjCWpox1jqHkry7OWuM6?=
 =?us-ascii?Q?V3+SrBi7UPu7Y3JExy8nhJrA4FNFBLIGNNoMYnPZECL0XZZ7GeJbFUK7gPts?=
 =?us-ascii?Q?HxC87JoGzmTcDV3oWIxITHV2Mozc+Gn/6DdD7r3b9Xuiid97z1frFOqyMVuK?=
 =?us-ascii?Q?vfReRfHR5PDJejBlDy7dgnYSTtuM/xJaNciMwcmJoDKkt18TeXgZ9i3c1Spv?=
 =?us-ascii?Q?0aBrp/htqF4eGKcyge1cuoe+39d1XanRq9jiUdtbNyVakC64F9gqNAooQFLR?=
 =?us-ascii?Q?Qj+N5TKldDKJASvqPjc9203Gyv1bwHK5krf9rJgKUfFCXM2su8S8eskOPqLj?=
 =?us-ascii?Q?iklw3NaRQWTaO8wh3z67MIUqaHuiiyVxZ4cNkU9oM8V21W0fjSS9+1+pLoxl?=
 =?us-ascii?Q?b/vpVctZUUWR3xQVAbRGbY60N7XtwEuOHBlwC/Hd7Yx105j7Ht4Z0YWxWhxA?=
 =?us-ascii?Q?NN+F0JAi5kpqn82K9nheocnq0sR8x8KnqVqdElxgup3a3Rh0ax+1iYPXRxOi?=
 =?us-ascii?Q?GrD4B0diC0jl1eX+rZa9QCuilVM2XwBwanB2rlsyuA8nx0d3Wx9WG3EEFzMs?=
 =?us-ascii?Q?iljKF6zEZmGpoA8YaL0KZzLvf7vaRPRXzOKNCntXYKFL1zphqKL2F8skm2WQ?=
 =?us-ascii?Q?5tOA3/sD0cnsyYQp8sDPqWImWtk5nz3Kyxfgp+Gp9LDTLoxTMb+VfuPkrWrc?=
 =?us-ascii?Q?igC4XHlZx8DcwRpsTVTmSNjt/NzIS4fStWJwgLR2IvtaqId9LvcEmzPp2KDi?=
 =?us-ascii?Q?GvZLfnjSv7Nyv5tyYuUywMZuCPSeMi9Mbc4oQNBXKm+9CLfrTWGdy4eIYkZM?=
 =?us-ascii?Q?WNF0DsQaQ9arKcAV5tgJ4OgrxAX97dfvWjbp/7ytgUFzVi6QY1nuEEQA5lDN?=
 =?us-ascii?Q?hAKSQYi1pnrmyQ3cfZfkU1eGlneLAhbrl6byzEffUevEAgaNcO87HIGkTDSO?=
 =?us-ascii?Q?jsJlsat//dN1itjzhauTdZ5/0GkKMLIEKkgy32FTPqOcXXv81+W3L1WRqY85?=
 =?us-ascii?Q?4lznEtL+IYF64+fm9nq3B21f?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C11FA0652CB8C94B80C4F83FFEFD064A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e666c2-ab05-47bb-a0c5-08d96bf60dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 20:37:58.6066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ajWX4jlGpbCWQ8/3v2vw7WMsJXnjkFQ4Uyb/zE/DQB3Mrs+5q2ZYUPtl2zrgr2n3PnGPLr3sM2aF0TLm5k+4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3509
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300131
X-Proofpoint-GUID: b8i1sTqFYSyg4Ui8undUefYsJbYMxs4L
X-Proofpoint-ORIG-GUID: b8i1sTqFYSyg4Ui8undUefYsJbYMxs4L
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 30, 2021, at 2:18 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-08-30 at 18:02 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Aug 30, 2021, at 1:34 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Mon, 2021-08-30 at 13:24 -0400, Olga Kornievskaia wrote:
>>>> On Mon, Aug 30, 2021 at 1:04 PM Chuck Lever III
>>>> <chuck.lever@oracle.com> wrote:
>>>>>=20
>>>>> Hi Olga-
>>>>>=20
>>>>>> On Aug 30, 2021, at 12:53 PM, Olga Kornievskaia
>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>=20
>>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>>=20
>>>>>> Given the patch "Always provide aligned buffers to the RPC
>>>>>> read
>>>>>> layers",
>>>>>> RPC over RDMA doesn't need to look at the tail page and add
>>>>>> that
>>>>>> space
>>>>>> to the write chunk.
>>>>>>=20
>>>>>> For the RFC 8166 compliant server, it must not write an XDR
>>>>>> padding
>>>>>> into the write chunk (even if space was provided).
>>>>>> Historically
>>>>>> (before RFC 8166) Solaris RDMA server has been requiring the
>>>>>> client
>>>>>> to provide space for the XDR padding and thus this client
>>>>>> code
>>>>>> has
>>>>>> existed.
>>>>>=20
>>>>> I don't understand this change.
>>>>>=20
>>>>> So, the upper layer doesn't provide XDR padding any more. That
>>>>> doesn't
>>>>> mean Solaris servers still aren't going to want to write into
>>>>> it.
>>>>> The
>>>>> client still has to provide this padding from somewhere.
>>>>>=20
>>>>> This suggests that "Always provide aligned buffers to the RPC
>>>>> read
>>>>> layers" breaks our interop with Solaris servers. Does it?
>>>>=20
>>>> No, I don't believe "Always provide aligned buffers to the RPC
>>>> read
>>>> layers" breaks the interoperability. THIS patch would break the
>>>> interop.
>>>>=20
>>>> If we are not willing to break the interoperability and support
>>>> only
>>>> servers that comply with RFC 8166, this patch is not needed.
>>>=20
>>> Why? The intention of the first patch is to ensure that we do not
>>> have
>>> buffers that are not word aligned. If Solaris wants to write
>>> padding
>>> after the end of the file, then there is space in the page buffer
>>> for
>>> it to do so. There should be no need for an extra tail in which to
>>> write the padding.
>>=20
>> The RPC/RDMA protocol is designed for hardware-offloaded direct data
>> placement. That means the padding, which isn't data, must be directed
>> to another buffer.
>>=20
>> This is a problem with RPC/RDMA v1 implementations. RFC 5666 was
>> ambiguous, so there are implementations that write XDR padding into
>> Write chunks. This is why RFC 8166 says SHOULD NOT instead of MUST
>> NOT.
>>=20
>> I believe rpcrdma-version-two makes it a requirement not to use XDR
>> padding in either Read or Write data payload chunks.
>>=20
>>=20
> Correct, but in order to satisfy the needs of the Solaris server,
> you've hijacked the tail for use as a data buffer. AFAICS it is not
> being used as a SEND buffer target, but is instead being turned into a
> write chunk target. That is not acceptable!

The buffer is being used as both. Proper function depends on the
order of RDMA Writes and Receives on the client.

rpcrdma_encode_write_list() registers up to an extra 3 bytes in
rq_rcv_buf.tail as part of the Write chunk. The R_keys for the
segments in the Write chunk are then sent to the server as part
of the RPC Call.

As part of Replying, the server RDMA Writes data into the chunk,
and possibly also RDMA Writes padding. It then does an RDMA Send
containing the RPC Reply.

The Send data always lands in the Receive buffer _after_ the Write
data. The Receive completion guarantees that previous RDMA Writes
are complete. Receive handling invalidates and unmaps the memory,
and then it is made available to the RPC client.


> It means that we now are limited to creating COMPOUNDs where there are
> no more operations following the READ op because if we do so, we end up
> with a situation where the RDMA behaviour breaks.

I haven't heard reports of a problem like this.

However, if there is a problem, it would be simple to create a
persistently-registered memory region that is not part of any RPC
buffer that can be used to catch unused Write chunk XDR padding.


>>> This means that the RDMA and TCP cases should end up doing the same
>>> thing for the case of the Solaris server: the padding is written
>>> into
>>> the page buffer. There is nothing written to the tail in either
>>> case.
>>=20
>> "Always provide" can guarantee that the NFS client makes aligned
>> requests for buffered I/O, but what about NFS direct I/O from user
>> space? The NIC will place the data payload in the application
>> buffer, but there's no guarantee that the NFS READ request will be
>> aligned or that the buffer will be able to sink the extra padding
>> bytes.
>>=20
>> We would definitely consider it an error if an unaligned RDMA Read
>> leaked the link-layer's 4-byte padding into a sink buffer.
>>=20
>> So, "Always provide" is nice for the in-kernel NFS client, but I
>> don't believe it allows the way xprtrdma behaves to be changed.
>>=20
>=20
> If you're doing an unaligned READ from user space then you are already
> in a situation where you're doing something that is incompatible with
> block device requirements.
> If there really are any applications that contain O_DIRECT code
> specifically for use with NFS, then we can artificially force the
> buffers to be aligned by reducing the size of the buffer to align to a
> 4 byte boundary. NFS supports returning short reads.

Or xprtrdma can use the scheme I describe above. I think that
would be simpler and would avoid layering violations.

That would also possibly address the Nvidia problem, since a
pre-registered MR that handles Write padding would always be a
separate RDMA segment.

Again, I doubt this is necessary to fix any operational problem
with _supported_ use cases, but let me know if you'd like me to
make this change.


>>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>>> ---
>>>>>> net/sunrpc/xprtrdma/rpc_rdma.c | 15 ---------------
>>>>>> 1 file changed, 15 deletions(-)
>>>>>>=20
>>>>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c
>>>>>> b/net/sunrpc/xprtrdma/rpc_rdma.c
>>>>>> index c335c1361564..2c4146bcf2a8 100644
>>>>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>>>>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>>>>>> @@ -255,21 +255,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt
>>>>>> *r_xprt, struct xdr_buf *xdrbuf,
>>>>>>               page_base =3D 0;
>>>>>>       }
>>>>>>=20
>>>>>> -     if (type =3D=3D rpcrdma_readch)
>>>>>> -             goto out;
>>>>>> -
>>>>>> -     /* When encoding a Write chunk, some servers need to
>>>>>> see an
>>>>>> -      * extra segment for non-XDR-aligned Write chunks. The
>>>>>> upper
>>>>>> -      * layer provides space in the tail iovec that may be
>>>>>> used
>>>>>> -      * for this purpose.
>>>>>> -      */
>>>>>> -     if (type =3D=3D rpcrdma_writech && r_xprt->rx_ep-
>>>>>>> re_implicit_roundup)
>>>>>> -             goto out;
>>>>>> -
>>>>>> -     if (xdrbuf->tail[0].iov_len)
>>>>>=20
>>>>> Instead of checking for a tail, we could check
>>>>>=20
>>>>>         if (xdr_pad_size(xdrbuf->page_len))
>>>>>=20
>>>>> and provide some tail space in that case.
>>>>=20
>>>> I don't believe this is any different than what we have now. If
>>>> the
>>>> page size is non-4byte aligned then, we would still allocate size
>>>> for
>>>> the padding which "SHOULD NOT" be there. But yes it is allowed to
>>>> be
>>>> there.
>>>>=20
>>>> The problem, as you know from our offline discussion, is
>>>> allocating
>>>> the tail page and including it in the write chunk for the Nvidia
>>>> environment where Nvidia doesn't support use of data (user) pages
>>>> and
>>>> nfs kernel allocated pages in the same segment.
>>>>=20
>>>> Alternatively, my ask is then to change rpcrdma_convert_iovs() to
>>>> return 2 segs instead of one: one for the pages and another for
>>>> the
>>>> tail.
>>>>=20
>>>>>=20
>>>>>> -             rpcrdma_convert_kvec(&xdrbuf->tail[0], seg,
>>>>>> &n);
>>>>>> -
>>>>>> -out:
>>>>>>       if (unlikely(n > RPCRDMA_MAX_SEGS))
>>>>>>               return -EIO;
>>>>>>       return n;
>>>>>> --
>>>>>> 2.27.0
>>>>>>=20
>>>>>=20
>>>>> --
>>>>> Chuck Lever
>>>>>=20
>>>>>=20
>>>>>=20
>>>=20
>>> --=20
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



