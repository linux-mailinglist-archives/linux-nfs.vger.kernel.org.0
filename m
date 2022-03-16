Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B264DB572
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 16:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbiCPP4o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 11:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357407AbiCPP4i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 11:56:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2052D5F4F4
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 08:55:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GF5c0P009569;
        Wed, 16 Mar 2022 15:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bo297Xlo4rmJ+y/l9V+h2qGAgmc4SZQGDvCJM9LMpao=;
 b=o3aoKFLcB6BkvUgT8bCr8JxS7hbMiDOf4uKkI8CSReUG1WF2pkzB70OZ/v9EHKmHGxXU
 9hDFcPTstb1A01Dcwk9dNkJpHUoS+pFvFvRmT2heVRMRRljhgwFApxZ4DJvo5crNYc38
 9ccPw3hcr+64m6Bq4jRM7WF8fn8EzkrVFGxFLCpv35V7IagP1b6CAckJSexXtnCNE+H7
 ZyV5KYuV26n4/86uRLPbNtxQkbwewPcvjYvYwbitq1kY9PxDJd5iosY9JIksosvZwNE4
 YBUpfdnxJ/0LVobE4eyIKp1elE0zp1iTd29KOZuJaVdrXkDagxwWP3eLOxDy6r+FHT8k IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rpphc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 15:55:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GFst3U002431;
        Wed, 16 Mar 2022 15:55:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3et65q01bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 15:55:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVrx7gLL1ac/2qQZpFua0D8uihhJMbKZiR8peDew12IF9MZE2RA32zFhTIrw8D7Nn9XLF6P/tcaETQG40u4hEZYRrzvgWx7mAwZh42D+L9x9DWynJMk1H/dR1Zp+Y++X8M8rPs32dti1ha6eCVbb0MxZ9Fe0IUL6tyINhsR9rD766KdP1NQJouTLwVaMxnYJmdEo4lpHQ2a5GJ78QBN4g2kv0URsMVfbeoZLLMqAMUvBa1jNiUL3Tc+IjPKoCz7Sidzxsc8SH+8nfz71ObXO0SUDK+0QCXeqpWnLByH666s8M2NNj96u3eDI8rUxoVquniGXvIlcDPhX7ESjC3SXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo297Xlo4rmJ+y/l9V+h2qGAgmc4SZQGDvCJM9LMpao=;
 b=CqBQHzQzxfb7/ue+++MaUKwGGz4QytSuPQRb7RtLAMxp63Ub3JCaC0C6EbjMQe/Ogy1j1cLKO8UbIGUSOj+wIAzemAfPodn7cuFwQs6FvSZsgwMi4kwOLy/hplOcM7pSalVd7fn9MynWynZ2pCr6UDOuF5w7FeVYefmmwrpxH8PUKw7iPdoSPk6a+r6joXV0U9pRRWwVEjtNdzzB7N9M39j32pt20DmusnEZAO9kC0XE3Hf40gFD2Uv4sy3jfYO4ZYZVhTY/m7vW4Xlbo4jxNVjdn0peuOlSaasDhW8bikmWTtyeZHa9jadi/6b2I9EVS4RrG8uJ9b6wke46b8h7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo297Xlo4rmJ+y/l9V+h2qGAgmc4SZQGDvCJM9LMpao=;
 b=TGLzBKRTNSceu24VLdxUX1DKf94PchsmT3Rwjj74fjivWKt0wh0ElO9VcDk6C4pxYao59rbrUt902yjjlOmJ3GDsUymgLki8KRAom7wyWXN8FTCb9L/TPfwJ3J9ozORVYbowIFTw3yLjW2/lQIktuVKijrBfQeO19iKzFq6EttA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB2897.namprd10.prod.outlook.com (2603:10b6:208:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 15:55:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 15:55:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Thread-Topic: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Thread-Index: AQHYNz9tXzp0vUT6Z02tg1tG8znMeKy/CFqAgACT9wCAApGeAA==
Date:   Wed, 16 Mar 2022 15:55:11 +0000
Message-ID: <9A7BF2ED-E125-4FEF-B984-C343C9E142F0@oracle.com>
References: <164721984672.11933.15475930163427511814@noble.neil.brown.name>
 <ED6618CE-EC09-448D-904C-F34FCE8E8935@oracle.com>
 <164730488811.11933.18315180827167871419@noble.neil.brown.name>
In-Reply-To: <164730488811.11933.18315180827167871419@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbb35e18-900f-4506-6138-08da07655a5b
x-ms-traffictypediagnostic: BL0PR10MB2897:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2897A06DD4EC2AB491E9538B93119@BL0PR10MB2897.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aztYaDB5iAVysPDU3s1tk1LZsTOot0EPWo/qQPlDvDecdCf5BM8joS5iQFbyHH2xQQvqTuEZmfGDymOX0CZ1IW+YjHqm9+oT+g3CxOGmoAqyRnUSYK2fZWgq2+m/CHSPv1FtFLrClwOzTiKKz63kMhDuYoF3GsnrWKwoxZ7SPgG06V7NnlFz135sQ4mwDhDIw9FQvRFGchuxfFSS/KlExAnMvjB0QEc29oJN6hvlfg+RB1iJkpYaWRRq3swt6wei15kcNlTwe9UsezHNyAq2DCY9Du1Vb5fG0cEDK24W52aWngTMCepk5i6qJDYcEdO44Mk6CumQLlf708xbAkvps9+7JMvBQSV18tB74DsblIrCNJEzJH4uIQtgwW+/i62EoaAVywOnulAz7lIiu9zwKbhCMFMpNiNgp/gUIhyw0Zi7bdxLuCTrq2Pf7oGAEwYZYJVFDiFKbmaW7Kmk4gSwGrKDJ0/BLaef5quPBcTLTYVpBfoJottUFgHN2fdlaK9jcz9TJw+lE0VVwvHV1sloyUYSzc/80N4vlBye5uvMxXs7K/fncdLurRbDgYj+hVmwc+T6L6Q0UyCqx/dmwY9XXrqNVJYe58oEhjfDh93aRLzZJTpQgwwiqYHc/udwmiVP3ZyrdZV4ruFLWnmfnkLyoBylnZd3uYfXGlwGuY6OkUfyi50BOfyFc5ai0tFgrQ12DDiXEkJMsSnjkggbPs+5z9UHpsBEH/TxGQgwbVSto/Ae63WPF1t5PPI9AXEb6LYw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(122000001)(38100700002)(316002)(2906002)(71200400001)(86362001)(54906003)(6916009)(33656002)(8676002)(4326008)(91956017)(6486002)(6512007)(508600001)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(8936002)(30864003)(53546011)(186003)(26005)(5660300002)(2616005)(6506007)(83380400001)(36756003)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tMsWIUO2WIAa3urqdEKqDpN2RALmajsefmpG/79TwKgZD0v9dj376VngG5fP?=
 =?us-ascii?Q?WVtiMOQki/yu1IErY7/XmRxzXqvk2cleqFuZAlyCWwmdgd/jYgfM+RhNExbI?=
 =?us-ascii?Q?e/pBscc6HMyVjq8WVgGbSJ2cXsik5j2KT7HbAfVLwihzfyteNT4UciZURpta?=
 =?us-ascii?Q?yG88mBkG+xpCazzAiaFkODpxrBOL7LAaloCQADGD6qiAvb61+w4bOuDeioY7?=
 =?us-ascii?Q?NMX+5xKJxl1A/A2b6C5qpJfTFRG+s8jdXNHSDlF06mc4HvfVaA3YcEy2g7Ex?=
 =?us-ascii?Q?CVV4WtQLJHF4tPC5Hugy8ZhXrlMDIe89OhXFJFfjzuSxppAQ7Y7qT7JRpyHA?=
 =?us-ascii?Q?Cs+d8JzQmpNeO0zexN20QYLMzwSajyO1U+Bd1za0O4QhH9ryKnDAh1l8EdNp?=
 =?us-ascii?Q?GWYZKjGQB080K5peGAeumbrEv32v2hWHO5PXaRifzuvZuX9YiRZ6jh4FXxOz?=
 =?us-ascii?Q?w9w2ZUROb96VE8ZuHnt+XKiHNETEbd+XtlVXjB/5UgAV28jqhJWMhx0a1G1u?=
 =?us-ascii?Q?l7i9eoiC/PusLvJH0teK9UhtIvvDSc5/u2ygzDGLfZn2u3GyWGsaTZbYBQoF?=
 =?us-ascii?Q?AzlIjDKgmoN1eELno+WepX2lOOQtb6eLmffcazLYrYt9tFPs8P+KUIa60VZw?=
 =?us-ascii?Q?fzcb5EHGIaA6fwVaItzLj3YSN1mvwHkUQrwxuhIl6Bu7ucatXROE6Rjt+qKs?=
 =?us-ascii?Q?F4JAgsZylKQkEuV1jJCzlXkRnB11PQqgG+jQMVezhRWV5HrRovUasHcZVtaM?=
 =?us-ascii?Q?OaJMuq4G2CbljRwdxgJndhH+90rkffj5NXOHWe+qutQOv0K45kO3hEIiMs5f?=
 =?us-ascii?Q?39pDAQmmOpa4kLoIoMhecS083wrQGb5Eru4cEy8aQw0u1498nf2oF4gWYISO?=
 =?us-ascii?Q?4ZSVTCuEPqV1sRtwFTK+bKr9jn7XFRVn5mavGm5Ow0NppiiWl5XoxEKPRfnh?=
 =?us-ascii?Q?NGSogAAdXPtw/PyZwgfu85hI8Q1/cpgtFg69WOZKfOqFeYYk7HxEAICaVGH4?=
 =?us-ascii?Q?svEotpq7/tAjKc6Rg8KCgsTnLgd704VnI4Tz2BFCLi5eFVP540ok3iHF/tYM?=
 =?us-ascii?Q?isddloX4alEc/xs3fZvZwQW5OsIQtLaRWgLLywHCXdx6jfVxlrp0B63074qS?=
 =?us-ascii?Q?baR1p3nnD0FopDb/joq/LFZdDCuzefAsmPkVC2dEMUSI9zIyhkahh5ceazn4?=
 =?us-ascii?Q?0nUL3PoaUJAvhUZrsXW5ryQ7zlQWHXyPf/oV8gbPA9e8+Bjsqk5f8W0Ev6iu?=
 =?us-ascii?Q?ofpZhzuYj9pZ2r7mdtZ5yqa1MHsPDfAevMGCNZXgF4blgwhckGeMEBIahzCK?=
 =?us-ascii?Q?cPnZ4UkbghHdqnDgfeazPOfHMG89ZAsR3AZWpBhgFEOSuZ0PNJwFRYebAv9J?=
 =?us-ascii?Q?XXgJRt58niLCaGfw/Mf7sPvl3Dcm7beuZpsSMOjOVNm9UI8UcAh4cHyjE9Ii?=
 =?us-ascii?Q?kC9geIwCi95eoO74rvY5OgKdL73ahR8D4zDrI6FvixMI0XT1rtP0ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13E17E81A0AB8B40A6A38D30F0EF6209@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb35e18-900f-4506-6138-08da07655a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 15:55:11.4126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPieVTdYqkvqLqGnugBRpswCTU3dRZ8fwUePFzlg+BoQSg40Ab4NbcqDm0am4djef2rkuyssEHqaeJFC2bSyog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2897
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160098
X-Proofpoint-ORIG-GUID: Z5nZ6E3qmQzfYz7uyv9SBIKjL6OEK4Dk
X-Proofpoint-GUID: Z5nZ6E3qmQzfYz7uyv9SBIKjL6OEK4Dk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Howdy Neil-

> On Mar 14, 2022, at 8:41 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 15 Mar 2022, Chuck Lever III wrote:
>> Hi Neil-
>>=20
>>> On Mar 13, 2022, at 9:04 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>>=20
>>> When mounting NFS filesystem in a network namespace using v4, some care
>>> must be taken to ensure a unique and stable client identity.  Similar
>>> case is needed for NFS-root and other situations.
>>>=20
>>> Add documentation explaining the requirements for the NFS identity in
>>> these situations.
>>>=20
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>>=20
>>> I think I've address most of the feedback, but please forgive and remin=
d
>>> if I missed something.
>>> NeilBrown
>>>=20
>>> utils/mount/nfs.man | 109 +++++++++++++++++++++++++++++++++++++++++++-
>>> 1 file changed, 108 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
>>> index d9f34df36b42..5f15abe8cf72 100644
>>> --- a/utils/mount/nfs.man
>>> +++ b/utils/mount/nfs.man
>>> @@ -1,7 +1,7 @@
>>> .\"@(#)nfs.5"
>>> .TH NFS 5 "9 October 2012"
>>> .SH NAME
>>> -nfs \- fstab format and options for the
>>> +nfs \- fstab format and configuration for the
>>> .B nfs
>>> file systems
>>=20
>> Suggest "configuration for nfs file systems" (remove "the")
>=20
> Agreed.
>=20
>>=20
>>=20
>>> .SH SYNOPSIS
>>> @@ -1844,6 +1844,113 @@ export pathname, but not both, during a remount=
.  For example,
>>> merges the mount option
>>> .B ro
>>> with the mount options already saved on disk for the NFS server mounted=
 at /mnt.
>>> +.SH "NFS CLIENT IDENTIFIER"
>>> +NFSv4 requires that the client present a unique identifier to the serv=
er
>>> +to be used to track state such as file locks.  By default Linux NFS us=
es
>>> +the host name, as configured at the time of the first NFS mount,
>>> +together with some fixed content such as the name "Linux NFS" and the
>>> +particular protocol version.  When the hostname is guaranteed to be
>>> +unique among all client which access the same server this is sufficien=
t.
>>> +If hostname uniqueness cannot be assumed, extra identity information
>>> +must be provided.
>>=20
>> The last sentence is made ambiguous by the use of passive voice.
>>=20
>> Suggest: "When hostname uniqueness cannot be guaranteed, the client
>> administrator must provide extra identity information."
>=20
> Why must the client administrator do this?  Why can't some automated
> tool do this?  Or some container-building environment.
> That's an advantage of the passive voice, you don't need to assign
> responsibility for the verb.

My point is that in order to provide the needed information,
elevated privilege is required. The current sentence reads as
if J. Random User could be interrupted at some point and asked
for help.

In other words, the documentation should state that this is
an administrative task. Here I'm not advocating for a specific
mechanism to actually perform that task.


>> I have a problem with basing our default uniqueness guarantee on
>> hostnames "most of the time" hoping it will all work out. There
>> are simply too many common cases where hostname stability can't be
>> relied upon. Our sustaining teams will happily tell us this hope
>> hasn't so far been born out.
>=20
> Maybe it has not been born out because there is no documented
> requirement for it that we can point people to.
> Clearly containers that use NFS are not currently all configured well to =
do
> this.  Some change is needed.  Maybe adding a unique host name is the
> easiest change ... or maybe not.

You seem to be documenting the client's current behavior.
The tone of the documentation is that this behavior is fine
and works for most people.

It's the second part that I disagree with. Oracle Linux has
bugs documenting this behavior is a problem, and I'm sure
Red Hat does too. The current behavior is broken. It is this
brokeness that we are trying to resolve.

So let me make a stronger statement: we should not
document that broken behavior in nfs(5). Instead, we should
fix that behavior, and then document the golden brown and
delicious behavior. Updating nfs(5) first is putting
DeCarte in front of de horse.


> Surely NFS is not the *only* service that uses the host name.
> Encouraging the use of unique host names might benefit others.

Unless you have specific use cases that might benefit from
ensuring hostname uniqueness, I would beg that you stay
focused on the immediate issue of how the Linux client
constructs its nfs_client_id4 strings.


> The practical reality is that a great many NFS client installations do
> currently depend on unique host names - after all, it actually works.
> Is it really so unreasonable to try to encourage the exceptions to fit
> the common pattern better?

Yes it is unreasonable.

NFS servers typically have a fixed DNS presence. They have
to because clients mount by hostname.

NFS clients, on the other hand, are not under that constraint.
The only time I can think of where a client has to have a
fixed hostname is if a krb5 host principal is involved.

In so many other cases, eg. mobile computing or elastic
services, the client hostname is mutable. I don't think
it's fair to put another constraint on host naming here,
especially one with implications of service denial or
data corruption (see below).


>> Maybe I'm just stating this to understand the purpose of this
>> patch, but it could also be used as an "Intended audience"
>> disclaimer in this new section.
>=20
> OK, so the "purpose of this patch" relates in part to a comment you made
> earlier, which I include here:
>=20
>> Since it is just a line or two of code, it might be of little
>> harm just to go with separate implementations for now and stop
>> talking about it. If it sucks, we can fix the suckage.
>>=20
>> Who volunteers to implement this mechanism in mount.nfs ?
>=20
> I don't think this is the best next step.  I think we need to get some
> container system developer to contribute here.  So far we only have
> second hand anecdotes about problems.  I think the most concrete is from
> Ben suggesting that in at least one container system, using
> /etc/machine-id is a good idea.
>=20
> I don't think we can change nfs-utils (whether mount.nfs or mount.conf
> or some other way) to set identity from /etc/machine-id for everyone.
> So we need at least for that container system to request that change.
>=20
> How would they like to do that?
>=20
> I suggest that we explain the problem to representatives of the various
> container communities that we have contact with (Well...  "you", more
> than "we" as I don't have contacts).

I'm all for involving one or more container experts. But IMO
it's not appropriate to update our man page to do that. Let's
update nfs(5) when we are done with this effort.


> We could use the documentation I provided to clearly present the
> problem.

No doubt, we need a crisp problem statement!


> Then ask:
>  - would you like to just run some shell code (see examples)
>  - or would you like to provide an /etc/nfs.conf.d/my-container.conf
>  - or would you like to run a tool that we provide
>  - or is there already a push to provide unique container hostnames,
>    and is this the incentive you need to help that push across the
>    line?
>=20
> If we have someone from $CONTAINER_COMMUNITY say "if you do this thing,
> then we will use it", then that would be hard to argue with.
> If we could get two or three different communities to comment, I expect
> the best answer would become a lot more obvious.
>=20
> But first we, ourselves, need to agree on the document :-)

If the community is seeking help, then a wiki might be a better
place to formulate a problem statement.


>>> +.PP
>>> +Some situations which are known to be problematic with respect to uniq=
ue
>>> +host names include:
>>=20
>> A little wordy.
>>=20
>> Suggest: "Situations known to be problematic with respect to unique
>> hostnames include:"
>=20
> Yep.
>=20
>>=20
>> If this will eventually become part of nfs(5), I would first run
>> this patch by documentation experts, because they might have a
>> preference for "hostnames" over "host names" and "namespaces" over
>> "name-spaces". Usage of these terms throughout this patch is not
>> consistent.
>=20
> I've made it consistently "hostname" and "namespace" which is consistent
> with the rest of the document
>=20
>>=20
>>=20
>>> +.IP \- 2
>>> +NFS-root (diskless) clients, where the DCHP server (or equivalent) doe=
s
>>> +not provide a unique host name.
>>=20
>> Suggest this addition:
>>=20
>> .IP \- 2
>>=20
>> Dynamically-assigned hostnames, where the hostname can be changed after
>> a client reboot, while the client is booted, or if a client often=20
>> repeatedly connects to multiple networks (for example if it is moved
>> from home to an office every day).
>=20
> This is a different kettle of fish.  The hostname is *always* included
> in the identifier.  If it isn't stable, then the identifier isn't
> stable.
>=20
> I saw in the history that when you introduced the module parameter it
> replaced the hostname.  This caused problems in containers (which had
> different host names) so Trond changed it so the module parameter
> supplemented the hostname.
>=20
> If hostnames are really so poorly behaved I can see there might be a
> case to suppress the hostname, but we don't have that option is current
> kernels.  Should we add it?

I claim that it has become problematic to use the hostname in the
nfs_client_id4 string.

25 years ago when NFSv4.0 was being crafted, it was assumed that
client hostnames were unchanging. The original RFC 3010 recommended
adding the hostname, the client IP address, and the server IP
address to the nfs_client_id4 string.

Since then, we've learned that the IP addresses are quite mutable,
and thus not appropriate for a fixed identifier. I argue that the
client's hostname is now the same.

The Linux NFSv4 prototype and subsequent production code used the
local hostname because it's easy to access in the kernel via the
UTS name. That was adequate 20 years ago, but has become less so
over time. You can view this evolution in the commit log.

It doesn't seem that complicated (to me) to divorce the client_id4
string from the local hostname, and the benefits are significant.


>>> +.IP \- 2
>>> +"containers" within a single Linux host.  If each container has a sepa=
rate
>>> +network namespace, but does not use the UTS namespace to provide a uni=
que
>>> +host name, then there can be multiple effective NFS clients with the
>>> +same host name.
>>> +.IP \=3D 2
>>=20
>> .IP \- 2
>=20
> Thanks.
>=20
>>=20
>>=20
>>> +Clients across multiple administrative domains that access a common NF=
S
>>> +server.  If assignment of host name is devolved to separate domains,
>>=20
>> I don't recognize the phrase "assignment is devolved to separate domains=
".
>> Can you choose a friendlier way of saying this?
>>=20
>=20
> If hostnames are not assigned centrally then uniqueness cannot be
> guaranteed unless a domain name is included in the hostname.

Better, thanks.


>>> +.RS
>>> +.PP
>>> +This value is empty on name-space creation.
>>> +If the value is to be set, that should be done before the first
>>> +mount.  If the container system has access to some sort of per-contain=
er
>>> +identity then that identity, possibly obfuscated as a UUID is privacy =
is
>>> +needed, can be used.  Combining the identity with the name of the
>>> +container systems would also help.
>>=20
>> I object to recommending obfuscation via a UUID.
>>=20
>> 1. This is confusing because there has been no mention of any
>>   persistence requirement so far. At this point, a reader
>>   might think that the client can simply convert the hostname
>>   and netns identifier every time it boots. However this is
>>   only OK to do if these things are guaranteed not to change
>>   during the lifetime of a client. In a world where a majority
>>   of systems get their hostnames dynamically, I think this is
>>   a shaky foundation.
>=20
> If the hostname changes after boot (weird concept ..  does that really
> happen?) that is irrelevant.

It really happens. A DHCP lease renewal can do it. Moving to a
new subnet on the same campus might do it. I can open "Device
Settings" on my laptop and change my laptop's hostname on a
whim. Joining a VPN might do it.

A client might have multiple network interfaces, each with a
unique hostname. Which one should be used for the nfs_client_id4
string? RFCs 7931 and 8587 discuss how trunking needs to work:
the upshot is that the client needs to have one consistent
nfs_client_id4 string it presents to all servers (in case of
migration) no matter which network path it uses to access the
server.


> The hostname is copied at boot by NFS, and
> if it is included in the /sys/fs/nfs/client/identifier (which would be
> pointless, but not harmful) it has again been copied.
>=20
> If it is different on subsequent boots, then that is a big problem and
> not one that we can currently fix.

Yes, we can fix it: don't use the client's hostname but
instead use a separate persistent uniquifier, as has been
proposed.


> ....except that non-persistent client identifiers isn't an enormous
> problem, just a possible cause of delays.

I disagree, it's a significant issue.

- If locks are lost, that is a potential source of data corruption.

- If a lease is stolen, that is a denial of service.

Our customers take this very seriously. The NFS clients's
out-of-the-shrink-wrap default behavior/configuration should be
conservative enough to prevent these issues. Customers store
mission critical data via NFS. Most customers expect NFS to work
reliably without a lot of configuration fuss.


>> 2. There's no requirement that this uniquifier be in the form
>>   of a UUID anywhere in specifications, and the Linux client
>>   itself does not add such a requirement. (You suggested
>>   before that we should start by writing down requirements.
>>   Using a UUID ain't a requirement).
>=20
> The requirement here is that /etc/machine-id is documented as requiring
> obfuscation.  uuidgen is a convenient way to provide obfuscation.  That
> is all I was trying to say.

Understood, but the words you used have some additional
implications that you might not want.


>>   Linux chooses to implement its uniquifer with a UUID because
>>   it is assumed we are using a random UUID (rather than a
>>   name-based or time-based UUID). A random UUID has strong
>>   global uniqueness guarantees, which guarantees the client
>>   identifier will always be unique amongst clients in nearly
>>   all situations for nearly no cost.
>>=20
>=20
> "Linux chooses" what does that mean?  I've lost the thread here, sorry.

Try instead: "The documentation regarding the nfs_unique_id
module parameter suggests the use of a UUID because..."


>> If we want to create a good uniquifier here, then combine the
>> hostname, netns identity, and/or the host's machine-id and then
>> hash that blob with a known strong digest algorithm like
>> SHA-256. A man page must not recommend the use of deprecated or
>> insecure obfuscation mechanisms.
>=20
> I didn't realize the hash that uuidgen uses was deprecated.  Is there
> some better way to provide an app-specific obfuscation of a string from
> the command line?
>=20
> Maybe
>    echo nfs-id:`cat /etc/machine-id`| sha256sum
>=20
> ??

Something like that, yes. But the scriptlet needs to also
involve the netns identity somehow.


>> The man page can suggest a random-based UUID as long as it
>> states plainly that such UUIDs have global uniqueness guarantees
>> that make them suitable for this purpose. We're using a UUID
>> for its global uniqueness properties, not because of its
>> appearance.
>=20
> So I could use "/etc/nfsv4-identity" instead of "/etc/nfs4-uuid".

I like. I would prefer not using "uuid" in the name. Ben and
Steve were resistant to that idea, though.


> What else should I change/add.
>=20
>>=20
>>=20
>>> For example:
>>> +.RS 4
>>> +echo "ip-netns:`ip netns identify`" \\
>>> +.br
>>> +   > /sys/fs/nfs/client/net/identifier=20
>>> +.br
>>> +uuidgen --sha1 --namespace @url  \\
>>> +.br
>>> +   -N "nfs:`cat /etc/machine-id`" \\
>>> +.br
>>> +   > /sys/fs/nfs/client/net/identifier=20
>>> +.RE
>>> +If the container system provides no stable name,
>>> +but does have stable storage,
>>=20
>> Here's the first mention of "stable". It needs some
>> introduction far above.
>=20
> True.  So the first para becomes:
>=20
>  NFSv4 requires that the client present a stable unique identifier to
>  the server to be used to track state such as file locks.  By default
>  Linux NFS uses the hostname, as configured at the time of the first
>  NFS mount, together with some fixed content such as the name "Linux
>  NFS" and the particular protocol version.  When the hostname is
>  guaranteed to be unique among all client which access the same server,
>  and stable across reboots, this is sufficient.  If hostname uniqueness
>  cannot be assumed, extra identity information must be provided.  If
>  the hostname is not stable, unclean restarts may suffer unavoidable
>  delays.

See above. The impact is more extensive than "unavoidable delays."


>>> then something like
>>> +.RS 4
>>> +[ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid &&=20
>>> +.br
>>> +cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier=20
>>> +.RE
>>> +would suffice.
>>> +.PP
>>> +If a container has neither a stable name nor stable (local) storage,
>>> +then it is not possible to provide a stable identifier, so providing
>>> +a random identifier to ensure uniqueness would be best
>>> +.RS 4
>>> +uuidgen > /sys/fs/nfs/client/net/identifier
>>> +.RE
>>> +.RE
>>> +.SS Consequences of poor identity setting
>>=20
>> This section provides context to understand the above technical
>> recommendations. I suggest this whole section should be moved
>> to near the opening paragraph.
>=20
> I seem to keep moving things upwards....  something has to come last.
> Maybe a "(See below)" at the end of the revised first para?
>=20
>>=20
>>=20
>>> +Any two concurrent clients that might access the same server must have
>>> +different identifiers for correct operation, and any two consecutive
>>> +instances of the same client should have the same identifier for optim=
al
>>> +crash recovery.
>>=20
>> Also recovery from network partitions.
>=20
> A network partition doesn't coincide with two consecutive instances of th=
e
> same client.  There is just one client instance and one server instance.

It's possible for one of the peers to reboot during the network
partition.


>>> +.PP
>>> +If two different clients present the same identity to a server there a=
re
>>> +two possible scenarios.  If the clients use the same credential then t=
he
>>> +server will treat them as the same client which appears to be restarti=
ng
>>> +frequently.  One client may manage to open some files etc, but as soon
>>> +as the other client does anything the first client will lose access an=
d
>>> +need to re-open everything.
>>=20
>> This seems fuzzy.
>>=20
>> 1. If locks are lost, then there is a substantial risk of data
>>   corruption.
>>=20
>> 2. Is the client itself supposed to re-open files, or are
>>   applications somehow notified that they need to re-open?
>>   Either of these scenarios is fraught -- I don't believe any
>>   application is coded to expect to have to re-open a file
>>   due to exigent circumstances.
>=20
> I wasn't very happy with the description either.  I think we want some
> detail, but not too much.
>=20
> The "re-opening" that I mentioned is the NFS client resubmitting NFS
> OPEN requests, not the application having to re-open.
> However if the application manages to get a lock, then when the "other"
> client connects to the server the application will lose the lock, and
> all read/write accesses on the relevant fd will result in EIO (I
> think).  Clearly bad.
>=20
> I wanted to say the clients could end up "fighting" with each other -
> the EXCHANGE_ID from one destroys the state set up by the other - I that
> seems to be too much anthropomorphism.
>=20
>    If two different clients present the same identity to a server there
>    are two possible scenarios.  If the clients use the same credential
>    then the server will treat them as the same client which appears to
>    be restarting frequently.  The clients will each enter a loop where
>    they establish state with the server and then find that the state
>    has been destroy by the other client and so will need to establish
>    it again.
>=20
> ???

My colleague Calum coined the term "lease stealing". That might be
a good thing to define somewhere and simply use that term as needed.


>>> +.PP
>>> +If the clients use different credentials, then the second client to
>>> +establish a connection to the server will be refused access.  For=20
>>> +.B auth=3Dsys
>>> +the credential is based on hostname, so will be the same if the
>>> +identities are the same.  With
>>> +.B auth=3Dkrb
>>> +the credential is stored in=20
>>> +.I /etc/krb5.keytab
>>> +and will be the same only if this is copied among hosts.
>>=20
>> This language implies that copying the keytab is a recommended thing
>> to do. It's not. I mentioned it before because some customers think
>> it's OK to use the same keytab across their client fleet. But obviously
>> that will result in lost open and lock state.=20
>>=20
>> I suggest rephrasing this last sentence to describe the negative lease
>> recovery consequence of two clients happening to share the same host
>> principal -- as in "This is why you shouldn't share keytabs..."
>>=20
>=20
> How about
>=20
> .PP
> If the clients use different credentials, then the second client to
> establish a connection to the server will be refused access which is a
> safer failure mode.  For
> .B auth=3Dsys
> the credential is based on hostname, so will be the same if the
> identities are the same.  With
> .B auth=3Dkrb
> the credential is stored in=20
> .I /etc/krb5.keytab
> so providing this isn't copied among client the safer failure mode will r=
esult.

With
.BR auth=3Dkrb5 ,
the client uses the host principal in
.I /etc/krb5.keytab
or in some cases, the lone user principal,
to authenticate lease management operations.
This securely prevents lease stealing.



> ??
>=20
> Thanks for your details review!
>=20
> NeilBrown
>=20
>>=20
>>> +.PP
>>> +If the identity is unique but not stable, for example if it is generat=
ed
>>> +randomly on each start up of the NFS client, then crash recovery is
>>> +affected.  When a client shuts down uncleanly and restarts, the server
>>> +will normally detect this because the same identity is presented with
>>> +different boot time (or "incarnation verifier"), and will discard old
>>> +state.  If the client presents a different identifier, then the server
>>> +cannot discard old state until the lease time has expired, and the new
>>> +client may be delayed in opening or locking files that it was
>>> +previously accessing.
>>> .SH FILES
>>> .TP 1.5i
>>> .I /etc/fstab
>>> --=20
>>> 2.35.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



