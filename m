Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11694473595
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 21:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhLMUG5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 15:06:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15612 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242825AbhLMUGw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 15:06:52 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDIj3G3022072;
        Mon, 13 Dec 2021 20:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WvAlComJacoDG8Wob/347qoFylRnUWBhP8y/nZ86WRI=;
 b=KYxBGIMZasKKZIbgdb5BzGWfcq7MXy6SiTXy/EmompnA2H+9VPsBRqmw5+6bGXzXDP5r
 6tDQSEZ1enONYYJn0nGzbPT1VyflWUCylm0/4QwTTw7IaZuNQOlfh4kDz/QVYGsU6XvC
 vpjzbluL8VEye2EHWzaRULmTngH3cqpbHkqgx3j8S7hDXgF/7m7Dqdu/TgB59cW1nTma
 w3UWMLWtaGNrbZ1lCSaoZZ4b+i6daZs9ZA9M8vGVBj0DDnJOq4vF9wfPZsSiz23dlypn
 ZEuzVeIEf84xebBbShg48AAPay9DPQHhhcv8e7jqIDqb3yoRNgT2nR2+6DboKvkuN3Vn qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nf9uxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 20:06:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDJoQZK066238;
        Mon, 13 Dec 2021 20:06:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 3cvkt3fa3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 20:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug7Ad4mXyGi4mHpvwxWW9I15taLvHwPe+EL8vEmnGYrS2RbeOG2GK02Mx1XJytnZbsmIs/Av3wjyky0Ei1S7tScfr+RNNb5vbsdb8FQv6bVhn9XNZU+Z0HvMUZyx2NV0GuUzn4trHInUloFJc9TDEgRJmKeciN8tojaXSX1N894xSj7ZyxUiFXlWGPh5Jopnl6cdyhSHtl10OJNt4CcNCxwkXidxloiuMfm6cVzeynYUPF54myUK+UJILMx8YN9QjoqghmjO29IT24c8ynLu2VYSCQGj2WaLI4mXsMuEll09EiLB2X2UEJy6BK848cpHxScZUCZ8I7bX6814LF1Hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvAlComJacoDG8Wob/347qoFylRnUWBhP8y/nZ86WRI=;
 b=m4yigZF53mRUaOddzbZqQJ1JT56xRt64IEhYAlmbEAt+my/gFtMNYhAvfKYxaw38XfPePKPWvWhw+Ori9AimGbaSTH/8e3IB8c+aVvcIePY98FGbAou+pqjhak5bDliEjR+Vb+wbnxcx6on/cjwDKZUbeikx/57jO8FVotbApXZFRkDqWzJNCEyzeiWD6VofrIP+hcRH9FhYBzrnKutMq0dLciVD/NtEArwMAOuJ0T7nfE75A7ukJVxfV11rQ4QoQaK/7ZASUQ0Pc7vCyWStlKzxPk/6qgzV/5zahNqvFuj18FyERN23WdPjGWGTkumX3/IOz86UPMxVyZSdbi1aqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvAlComJacoDG8Wob/347qoFylRnUWBhP8y/nZ86WRI=;
 b=vmy8XwlYafheoBzbZSuLrtfnsiR/j6z/Xid8iu9Mt86sXpMjM/gb9jlIr9QJBiq5nxgy3mA8PcndiVL6XXGBLuwNkPp/4ofFmaqUyQiTVhSJRrA1pYe+cIavjelvwN8+a8czandtHR9uVjli+Sf1jvPbAB73ySqi+U+ptbsAoko=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4873.namprd10.prod.outlook.com (2603:10b6:610:c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Mon, 13 Dec
 2021 20:06:46 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853%8]) with mapi id 15.20.4778.016; Mon, 13 Dec 2021
 20:06:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "rmacklem@uoguelph.ca" <rmacklem@uoguelph.ca>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: knfsd server returns writeverf of all 0 bits (but was not
 rebooted)
Thread-Topic: knfsd server returns writeverf of all 0 bits (but was not
 rebooted)
Thread-Index: AQHX7VIEQoc8yG9ZVUucpKOORDcyuqww2GaAgAADj4CAAANOgA==
Date:   Mon, 13 Dec 2021 20:06:46 +0000
Message-ID: <CC76C3FE-1F85-412D-BD3E-13662E7721DA@oracle.com>
References: <YQXPR0101MB09686CB60B96426316F4252ADD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <E98AB758-5406-449B-96E7-C7FBD0BA98B3@oracle.com>
 <6672752c94036f159816c19756fe4d77ca9bddd8.camel@hammerspace.com>
In-Reply-To: <6672752c94036f159816c19756fe4d77ca9bddd8.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b180b351-d420-4bbf-f135-08d9be741701
x-ms-traffictypediagnostic: CH0PR10MB4873:EE_
x-microsoft-antispam-prvs: <CH0PR10MB487334054420A8DB359BBD0693749@CH0PR10MB4873.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nB4bPrtXB9MJZgRLYnj15mA8RcwuDZrNbcG7LLHCfmBQY8ENgSr6Xh60A5QUu+3TTVkAVr+TZBsTAVLb0mRb7P2q0LVWfcra1iXzVtOdnn1kGyQ3hSvWjb64u03Fsgj93sueVK/GGcxUH4Gt7hlTrnlfE+7YE7RNm1AnU6lz0TSOllu1caoD50rMWn7ckdE5qklVtxPXFfMTnaNhzWrun1SS6aDvJJmxaz48098VNDDa1oF2BJUJmy0IQMBhqfkVBY5W/j2HZfjg2CJ2Ly8n5nwlF6IQ177vrMNSdv8yhjRxQmuz43Ezv8zq1dzZy618XYYr4UZX6NTMIZyB3i/EdhrABDdQ0EIvV/laUusyeuXyIL/t5XcichuRd7YRBIHER7Q/ALXLa5rxpWIE8d+RhYQe/q4yZjcxcJExQkSQ0DNyeAEVAwBKdRWQBzXlVAbotrk/tVGdlq7v3gUtJO4qG2DEyv0r9z2TC/P/vV8PmHN16pu9H0yGxcNI6y9vovbgiPku+UJ4BRw+QHwY8fJollxNmlt+H+887htpo6X3Bgl60EAam+tnI9ZOTGjV/0XBbQkk6O1OZdWi11KoFYI0UhiIvW9BGBS3+PhtVqi/9E5GlCrJtwlpAQf2dFsebWhJYUol4ScKvU/8PMXAbk03vUk2Blcm1Ok/VFzTi4lEQa8PMJIInRcd1WiAhdidr6+Z9XURs0QsZv0aijYryzHAwe4XiNU5SbUSwAs5mkR97dA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(38070700005)(122000001)(54906003)(6512007)(6916009)(83380400001)(38100700002)(8936002)(71200400001)(6486002)(2616005)(2906002)(36756003)(64756008)(66446008)(4001150100001)(508600001)(66476007)(66946007)(5660300002)(66556008)(76116006)(6506007)(4326008)(316002)(26005)(86362001)(53546011)(33656002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tt5S2CKUVf6oDigMqghWqebvVAtV/MNcLKZr6FFBANA5yUGEFxpu+O1H/vBD?=
 =?us-ascii?Q?xR4Z2O+ZjL//EqTRysxL8ZGgLDpeTIm5HJUMPy1H+QgUT4grrkdPEiyiXO2J?=
 =?us-ascii?Q?Bv+bDvp/Q42w78UWsqquvoQDmqBQg2M41K5qI4tmb+oHZqB0PrPiiGkPOgRy?=
 =?us-ascii?Q?34Rx/BnXr4BGL3fVjHEplLuDb6oQ9hT16TK9+gATMPf4nS/daCSv265XhnNK?=
 =?us-ascii?Q?E/7qs7zFWb7T7q7/Syba27d0WmgohmzXOIte4A0oZIWz13TBWFbQ63yEP23n?=
 =?us-ascii?Q?/0D2XDjOuD2jEXY9luNjC+Yb/HKP2doZgUSaMJgnMtVUmsgLnjDKTYp9v2Ac?=
 =?us-ascii?Q?tpn6JqZ/CTwiQ3l4OJMuC6H98qRMhnmjIKx7WlD/hnbzZbce9kHPPtfNvXQy?=
 =?us-ascii?Q?MQZNxYsWRBwlzcdOUysmuhaZcGtZwuw1o5k1BsL+9UZnBe9D3sHdksGm/E8O?=
 =?us-ascii?Q?+8zXGsnFsIrGj4PnK5nYR/5xrbmTBpWcwJWR6oWjLayR6uq5HykgE51wt8qi?=
 =?us-ascii?Q?uJ5d5DKWDubCx4XTSZev1rBuPaXx33mgs8OSBGg/X818Yk5aYNycENTbAxgK?=
 =?us-ascii?Q?lTk1yEyA48J+Z+CYNWlMMm3YXJcbtGKB1Bcg27QnpsfWL/DTDYcAaF24DW3m?=
 =?us-ascii?Q?gx7RYKlY81dW+i+3AwiQfpwJ4wlkHd7uPoCd/UBI31C7j7UhdTi1qR7Z6IB/?=
 =?us-ascii?Q?PvAtEcTJCK/ehGR0zMXM+VMjefaCHbrLWp3Ii5llRNUnU2LtTjtTcQ6ChZxj?=
 =?us-ascii?Q?IIzfw87lXBYKQKrhAYixe+poNydZkfikXc1FK0d9H7a13pB+rkTobVrDora0?=
 =?us-ascii?Q?lS2h+rclaziXJlmi1RCisphocTeTX3jzqi8pOVCBOxtMBMF4Tfmdko4sJaAn?=
 =?us-ascii?Q?Jc4yYMc1y2B3p13ygEArpLzUHbYRf/pN5MkwdhKkq/4WUl+MASwEw04DGvLc?=
 =?us-ascii?Q?Y3w9JiL7dbtpxsb6RJoz0/keM8kAHAZJntZOuFYRE5vkBQKG2pJn9krTG4ce?=
 =?us-ascii?Q?TKM+AzzpDK6X0ia8GO4NrOInzaqXnSlNjvTe3aQtSctT4D0Gmwj59pG+iC3j?=
 =?us-ascii?Q?bIPlaaDNeXkg/ZVl7zE81VaWCx9EKN97VydLjanzc/Qb/cyNxIwKJDNoORf/?=
 =?us-ascii?Q?3OVGGn/RFG+BnbHD3g5hSByu7M7qVYL4O//tPKjjEdwUtdC1FTk4S8n9XHYD?=
 =?us-ascii?Q?4e7cS6LogZebR+9nN7vfWNOJguVdRLb5ZrgIEBHlY8S+eJyjPPAFK9Y1OqtG?=
 =?us-ascii?Q?fDuKnA15eZ+lDm06tg3ndsBm5fbBH7QQbAvJTD76XioTVHgsZIHgshfe0iq1?=
 =?us-ascii?Q?LljzG938mQYN6XgsLzVHC/sSLDaKvwe6yn2vohs9fu/mgufLXsWc7LjfjJa7?=
 =?us-ascii?Q?N1HxKgZ9fS8mva/sIumzseu5z5vH0cWCFW0j8Ib8zLMwC2QCbWBFzDbOBmcW?=
 =?us-ascii?Q?yZO0Jy88Pt2rIEOM+LBGBDZtOCU1ePIQ4fgdTLZUlIQRlS1VIDJTpqd54Thu?=
 =?us-ascii?Q?htKrVqL5QRKhMCLSGrD3i7lQTD6WLucvEb4Tp++Y664vRtoxJieaojEbBxsl?=
 =?us-ascii?Q?mzdLVCKm3Kkps6U3A/xOzl9jHZ7aFcKS3qIuE3+fny560wx522K5oVys1QzL?=
 =?us-ascii?Q?8oaCM9H2o6AlLjEpmcUgOF4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <712E7ADA6142FA4483AC71219922F967@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b180b351-d420-4bbf-f135-08d9be741701
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 20:06:46.0341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEFMuWJajiQ7M81q0sMcDN9coRssW6mwT3KAr/Y/KoOHRGSiagGBGhKgNgoZZjMaMzXsC9je/12uLIy4AHe9XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=953 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130120
X-Proofpoint-ORIG-GUID: vd5vBEb-SiiZ_5Rlv5n3VjcxC15AM90q
X-Proofpoint-GUID: vd5vBEb-SiiZ_5Rlv5n3VjcxC15AM90q
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 13, 2021, at 2:54 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-12-13 at 19:42 +0000, Chuck Lever III wrote:
>> Hi Rick-
>>=20
>>> On Dec 9, 2021, at 6:15 PM, Rick Macklem <rmacklem@uoguelph.ca>
>>> wrote:
>>>=20
>>> Hi,
>>>=20
>>> When testing against the knfsd in a Linux 5.15.1 kernel, I received
>>> a
>>> write reply with FILE_SYNC and a writeverf of all 0 bytes.
>>> (Previous write verifiers were not all 0 bytes.)
>>>=20
>>> The server seemed to be functioning normally and had not rebooted.
>>>=20
>>> Is this intended behaviour?
>>>=20
>>> Normally I would not expect the writeverf in a Write operation
>>> reply
>>> to change unless the server had rebooted, but I can see there might
>>> be circumstances where the knfsd server wants all non-FILE_SYNC
>>> writes to be redone by the client and would choose to change the
>>> writeverf.
>>> However, changing it to all 0 bytes seems particularly odd?
>>=20
>> I don't immediately see a code path for WRITE or COMMIT that would
>> set the verifier to zeroes. When Linux NFSD resets its write
>> verifier,
>> it sets it to the current time.
>>=20
>> Do you have a reproducer you can share?
>>=20
>=20
> Rick is using FILE_SYNC, whereas nfsd_vfs_write() only actually sets
> the boot verifier if the write is unstable or DATA_SYNC.

It wasn't clear from Rick's note that the verifier change he
observed was not permanent.

So then the answer to "Is this intended behavior?" is "Yes,
Linux NFSD returns an all-zero verifier for FILE_SYNC writes,
since the client does not use the verifier in this case. The
boot verifier for subsequent non-FILE_SYNC writes is not
altered."


--
Chuck Lever



