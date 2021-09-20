Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0B412733
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Sep 2021 22:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhITUJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Sep 2021 16:09:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62732 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229849AbhITUHY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Sep 2021 16:07:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KK4FfD018157;
        Mon, 20 Sep 2021 20:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0nmW3tMe8hypUoUXa4BdqIW3nV8OUfCf+D7hFfE/0+E=;
 b=JSYdM3INJx1hRPAPB0RmEKy4f0C2dyVtEuel8zjCYAsBZbSfKw4na1a7mOsb3Zgydly6
 b/SBxwJVEPZjl+2wym1aCcKrvVAXWlikYAPBvAFYhiZAflQDR/d3Aj7xCaYMqZooznHT
 lVP9nu+wJ8cfzPXppwEecBVBWAh5gICzT6L2YBeJqjiqlFIFIiXX4TFRGohT8aPSy1bl
 wDEpdT9vPLv+Qjg0CGYf6J902THouc34NKh6aPTVP5ktgohcIe378TIAQHq1fqtR/3t0
 6ukgKS4Fdu+HymSOun1cAU17wREQ3zdrs6ZD9xyWQidNqti0iQSp3d/3nly1jRYPirc3 gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66j2masn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 20:05:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18KK5W8e105324;
        Mon, 20 Sep 2021 20:05:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3030.oracle.com with ESMTP id 3b557w1nr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 20:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOaGu7xWvJ8YkAKMeaeiDGEG9Lp59JsmreiJxKfPDl4qsxZfHFcHyFdAIr/fQf3AALPtmtkrS7mxpnW825gEVAfgna990bvOLtToVK0vb+xNEDPTxK+4UBcShr3BUEnp3Vh9EE2eFd7TuqHU2UBJ8pbDHmdvpSwVYeuiilSCAqAvQ+qYNhnUG6Rn53gWOXVaAEtMGfn1iZQYJbD5WVw3AG3h44K01HNXCrZd5KUE3tajtzrP9dTD4cDgoXOikgzBq3UGUREbdq+PSsdSvfPQ0yNIb/XgsctJ6EOfBXZ4pWkkD2alhqZAp8oNagLzdQoCe8nGSIBfvmR00eVKzY2fgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0nmW3tMe8hypUoUXa4BdqIW3nV8OUfCf+D7hFfE/0+E=;
 b=dPP7LaosuM/BD3zoi4hwHvWsPmBjukZZOKGUn3NhByqbGyG1v2qjVEKH7Hk7ojjIwPQQrkutFG2LsoEkNJ4tuCbHZH5nVNRBveuTIVh9HT1289AXUyVTZmhF19qankcsSwf1t0fOIxxyxtSiqKDYhK4IJSiOUMa3jRruvbb0ld3OBdlmorM14NF4ctFctroNU7BRckEVtPwumTDWl80LEApJF0r3WSg0r1RpSXFadqlQxJoj6b2YfVk7Vfci0RZskRfod6WN+vDSccz1pmovpMf2j2gWfSxa8U9uFa3YrtorWe9uT62PrCZmBFUzXC5i29uYQHWeUeTwFXOneZGkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nmW3tMe8hypUoUXa4BdqIW3nV8OUfCf+D7hFfE/0+E=;
 b=gUi/NKqeiQVegEwbkvVDfS82MVTZJxTLhM2bYGML9YDGjJ4CqRnUqOfdt+pyu1ILdRPao5VJ2tL4MvBeNrG8no3124tds1Eay9+9m2uQmrYK8LmJY/vQ/gqikgmLaBo9tYe7daN8YMe9/JBs7sjbCKs0SIJ6X7cJeC2EUjWoY04=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5646.namprd10.prod.outlook.com (2603:10b6:a03:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 20:05:49 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 20:05:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fslPfHYBEJkGXNGWvoY4o9atRAYKAgFtTqACAAASCAIABXCQA
Date:   Mon, 20 Sep 2021 20:05:49 +0000
Message-ID: <020BE911-46F2-40A6-8CF3-578087BBE242@oracle.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
 <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
 <680A4FB2-B90D-47E1-A390-36B3081B1464@oracle.com>
 <7bfcfea962bc88eca24fb6fdfcaa9ef47138e531.camel@hammerspace.com>
In-Reply-To: <7bfcfea962bc88eca24fb6fdfcaa9ef47138e531.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e551e19-6e41-4e33-9b5c-08d97c720ad7
x-ms-traffictypediagnostic: SJ0PR10MB5646:
x-microsoft-antispam-prvs: <SJ0PR10MB5646C4C2DD71997C946782D093A09@SJ0PR10MB5646.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gmO3rfo+B1qu68XCg88X+WK0RvIxLlaOFpYkq/BQmsrZm9Q9Z4EdCrOmNXqqeguHZxHAcO/SdJRHW1McB484kFpOm/7L40U/KpCK//T+ivicALWcyyBvELJpChePhsrIaXQPzYINmxMOD327Rct8gxtqYZdTTRoYWYYJeTwIVbLLNmpjPeZSWgG2Du1M3YflnSrBkTgyPZ0rch9oXLS41f6wnbGauvPRiX4IwfrW5fw/WoR1EyeET1+G0jeYxxT/B8cfY4vra/xzGP+/Q6ys8lsHOJn1ZHCCLQm7QcESZ1O97WERtU94JaZcPHIShS12ZiyVkZ6BlmgMPenff67QDUjkLqxPDMqrsNGXOcR0M1O5ZfE9+2KScm5xN5DTStzvPSENRohnO0sDnc72ew9jy9m7zIDj8BnU8YFJ/I/n2wV3lev9jT8O2OuYygjxSiTsUrGdcLQI6+EqoQInGtUtksUbkzIttnxcDOGW6CtWhUfp6SoUoHLXO6Cu+TtABzKLv00Er5xFe6P0R0HdyqnppSPGRtn29X1+DtRtpZAdu6jh/IxZl2C+bg6wEMSpzgG9zLLXb1oe9dYmf8tN4p67/77lIBkW0PbYUPK6PmcXTPtPzSPDDGP2SC6WrFfsJFMxvVoKEaV5QGCfwilSFGH3TLz74KInmYH9ufv5BxBjWh3UIZaHB5RaRZwRzmv1TeusBwpgSDz69zU+dWRqYho/BABJDPlAJ4TzpjI574mMvVv7vxuO7EeCMwzR3UL7gtBf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(83380400001)(76116006)(91956017)(66946007)(26005)(6506007)(38100700002)(186003)(508600001)(6486002)(36756003)(2906002)(4326008)(2616005)(53546011)(316002)(66446008)(122000001)(8936002)(6916009)(38070700005)(8676002)(33656002)(86362001)(71200400001)(66476007)(5660300002)(3480700007)(64756008)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A0xFfcCcoAoJ7M7VWfUoWlBuXCbP9fcS6LywcrI5fYn7uxtqN533Lj7Un4SI?=
 =?us-ascii?Q?eA3a/mmsfPF7UyDJdgGGI8IXpFy4fdv6GO82VHWRMQ7phktEHnBHHEa2jscT?=
 =?us-ascii?Q?ASMfJi3Ga5DSED2i1FJQwMQ4tBvIUXWF7x/tffnX9DgH1zxHk+/K7JFfYbgP?=
 =?us-ascii?Q?/069/BAVeqbY9ayMipldkMU4WGFgm/AzJ+S0qru8vSpaicR/0tpl393LC9R9?=
 =?us-ascii?Q?/7nZp5P1cgyEjQkDxUeKpBQ1YdewruzbvRGmfhzvXuIJNL4x+DT7b2FNng9i?=
 =?us-ascii?Q?bQsq/ydtoeRwpUtlJof6XxSw7mSg4OsBNdhV8qju5K5mjkWoh2w5tAkdeVsC?=
 =?us-ascii?Q?jfZAoO2z/NkoPFMweraIfx+f++UGN/Q5UqBZi3nWuGONBY8w5Cza5K26gTuD?=
 =?us-ascii?Q?3r3Ewcmr3yrZ78x1arpvWkWjrzJ++GH4Ul8N+Hmf1hxscmZPHyJ1zb2Jd4x7?=
 =?us-ascii?Q?VFP571/6m9wuro+lDmeN6pTiucqh8UuCnjYOl0A3UXk6NCnqB9vXqT5e0zbS?=
 =?us-ascii?Q?bU3e87vmWrEESnYld/2G+WuHgVtbP06lqDq3jEAFbnjmA24Ay6IsUJ6CY7bp?=
 =?us-ascii?Q?bWAK2kp69B1LJeRXmmtDLOJBEZRySd+aUWdAjytBo6u4Xw/cbH2hDxAc5AFl?=
 =?us-ascii?Q?Clay44wvGg2unRp/ah4sMa1G8nxI6UoRvp429APr/2Bb13hdmljuosgvTTOf?=
 =?us-ascii?Q?DBb74uvhm9oMQqYJigmyZcogQxPEl/WrvEZXZmtKJ3dGLQOMH3C2jnimZK45?=
 =?us-ascii?Q?lZ6NWEtp2XZvA8MBeED0nRowWMUhAHVtWSbG4qU6Ht4fP9Pdd0Z6aD4ZvrWn?=
 =?us-ascii?Q?F122uisFNYNj5tkTa2nF1YPZ1yWOuyhnNrTxZaAprG0yJkTLbhZ6pGNGdwL9?=
 =?us-ascii?Q?y97N9CioCqZbKBCXln0/wVrRKlYQKjb3eXuR8XnQF1RTYPYD52vMopdE8+6t?=
 =?us-ascii?Q?MB+T2rDr4MepBLl0xOpUCEidxtOchljsH1Y8bPZJt5dAJB4B2fU0nW7bniEt?=
 =?us-ascii?Q?tpO+tAUQAzUb9PDkugX37dmMvGcNhwzetJiupmk5q8HGISBn9kP5ccU9hOGk?=
 =?us-ascii?Q?5TaBccJui/doTiFuYJpOf6siS+HqAqtfVBO6M1R1rcCDn6Mt3wzDAWZ9kzwo?=
 =?us-ascii?Q?mhkdM8o9X/fm139mjK8pbUNLMV81B3ISSJpd9+JZWGcAFDlRfqtuxMq5nOZr?=
 =?us-ascii?Q?hTyyxqk12RFnlbwutZplrDFkwkWKakuuOoTeuWXKNgdsgShH99sIoQkM7BRG?=
 =?us-ascii?Q?EsQ1Iqnb9wyaapyqS9ad5+AppqG1V6uWpHfwDBMb5NehtM1799s2s21FpfJJ?=
 =?us-ascii?Q?SDxYPmxULdudAlNGdqTXVNe9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88BBDA16993FD94AA77CF4158F3113C7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e551e19-6e41-4e33-9b5c-08d97c720ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 20:05:49.8041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKFFgIJGA4HDLK5rZrWMFjfdgH7Be1Oj0IqNN9E6K4klWfcFiJr3CtZEqS4oxqOkzNOMSdJx2/hFOuyCl5X57w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200114
X-Proofpoint-GUID: SHIXrP_d-PTYZU2Yf3a3Kg58jjMGms6t
X-Proofpoint-ORIG-GUID: SHIXrP_d-PTYZU2Yf3a3Kg58jjMGms6t
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Sep 19, 2021, at 7:19 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sun, 2021-09-19 at 23:03 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 23, 2021, at 4:24 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Fri, 2021-07-23 at 20:12 +0000, Chuck Lever III wrote:
>>>> Hi-
>>>>=20
>>>> I noticed recently that generic/075, generic/112, and generic/127
>>>> were
>>>> failing intermittently on NFSv3 mounts. All three of these tests
>>>> are
>>>> based on fsx.
>>>>=20
>>>> "git bisect" landed on this commit:
>>>>=20
>>>> 7b24dacf0840 ("NFS: Another inode revalidation improvement")
>>>>=20
>>>> After reverting 7b24dacf0840 on v5.14-rc1, I can no longer
>>>> reproduce
>>>> the test failures.
>>>>=20
>>>>=20
>>>=20
>>> So you are seeing file metadata updates that end up not changing
>>> the
>>> ctime?
>>=20
>> As far as I can tell, a WRITE and two SETATTRs are happening in
>> sequence to the same file during the same jiffy. The WRITE does
>> not report pre/post attributes, but the SETATTRs do. The reported
>> pre- and post- mtime and ctime are all the same value for both
>> SETATTRs, I believe due to timestamp_truncate().
>>=20
>> My theory is that persistent-storage-backed filesystems seem to
>> go slow enough that it doesn't become a significant problem. But
>> with tmpfs, this can happen often enough that the client gets
>> confused. And I can make the problem unreproducable if I enable
>> enough debugging paraphernalia on the server to slow it down.
>>=20
>> I'm not exactly sure how the client becomes confused by this
>> behavior, but fsx reports a stale size value, or it can hit a
>> bus error. I'm seeing at least four of the fsx-based xfs tests
>> fail intermittently.
>=20
> It really isn't a client problem then. If the server is failing to
> update the timestamps, then you gets what you gets.

I don't think it's as simple as that.

The Linux VFS has clamped the resolution of file timestamps since
before the git era began. See current_time() and its ancestors.
The fsx-based tests start failing only after=20

7b24dacf0840 ("NFS: Another inode revalidation improvement")

was applied to the client. So until 7b24dacf0840, things worked
despite poor server-side timestamp resolution.

In addition, it's not terribly sensible that the client should
ignore changes that it made itself simply because the ctime on
the server didn't change. m/ctime has been more or less a hint
since day one, used to detect possible changes by _other_
clients. Here, the client is doing a SETATTR then throwing away
the server-returned attributes and presenting a stale file size
from its own cache to an application.

That smells awfully like a client regression to me.

In any event, as I said above, I'm not exactly sure how the
client is becoming confused, so this is not yet a rigorous
root-cause analysis. I was simply responding to your question
about file metadata updates without a ctime change. Yes, that
is happening, but apparently that is actually a pretty normal
situation.


--
Chuck Lever



