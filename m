Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DB440EA7C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Sep 2021 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbhIPS7y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Sep 2021 14:59:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21604 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239092AbhIPS7s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Sep 2021 14:59:48 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GI0Bcg019726;
        Thu, 16 Sep 2021 18:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=42RAJdOIdn3WlpiKE2PzJSRPiAiHL0Ua579av1mvcYg=;
 b=SFpkXMAVG3RFBQb1XyqerHV3cKB0AUzB1Lv8Kf8PWLc43Yzd3ay7pXnLZP5wkn0GVip2
 x61ZN/0k/VM23LS/yR4GbtOVx5dNPz9GmuNjZ1/IL36bp/cb8TVi8q1z56DqEcPhby+2
 c8EeEhjUtBh1K0D5IpkQ4Ukot7zRkGX3w6For49fGx2Q+UnD9/kfZ/jXL5+mieL5LPyP
 /XsUGJyTtmlthwCa4/HvQc0gCiFzdgKnhMJG60es4hVTOmwzX3ppGZdTA0V0zcNLektJ
 JAN0zMEmrfEx5E932DppPV5+ySWjZJqhE7+NPP5PgdNYeWH7sRC2B5G0eUqCySCDgkXI XA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=42RAJdOIdn3WlpiKE2PzJSRPiAiHL0Ua579av1mvcYg=;
 b=lFdOXU9pGr+Q6dJx2oM9OFNk+cYnaTUQpxkCdvUTZk6+Ki0fa2IW3pBVqMQeNTq6q+6x
 xif+/0fN0x/0fyusf7CW/hVWJxcQyPgbJty64gEAMkevZlCEV5Lgtng5gtIryn1WJghb
 BAqa6BXoYkzYx9hvX/eTwsEbHSoL6TvAwMbKfPm0o7vhGxs+dEqbytSD/qiEtIKdMmN+
 6815wydzVchbsqyL5OyHSolpak0o18+X8Lzp+l4FzWMXMX6rUw6xMjIURXODvAChzq7t
 7minNhLTAtfQ4111nxSoTXRo1P8CrxJTlzwYvesZt29I8/+ABiT0/oHjqMA6OmMCTkeG lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3t92kpf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 18:58:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GIoemM151759;
        Thu, 16 Sep 2021 18:58:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 3b0jggkdhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 18:58:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo+ngft+le6QuIogJ+hrizrD43QuNKha4UR5N5F0sXd8zVrHdxVudC4329UNQW0OaP+V3M6R5uvCKCamQAjMwU267Cj819PfmfFk1ia2OhHoT4p0X4HVIh8TbVJGcJ/xKMJj8SwyK7l1toB7dDS1JPjknxAViewq5/HO/AyBV6qRHEQ27z13riGzPubzHI6scSRRmkdh32RC5gL6MhJDVcBsj7A55GD5WD/A5vVSeH+3zeORWbnp8jQO46R1Z9i5d+stC2UO0q9UAWPpwQ1uuo8By31nc0N3FvumyHK/JC+hTVgccOS6gK90jnb6V0XcZbgcPGBKxbQkgg3hba3w4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=42RAJdOIdn3WlpiKE2PzJSRPiAiHL0Ua579av1mvcYg=;
 b=Ztxo7cDEsoeUsj399gpATStv3lTMT15thJ3erOwc9x+GmBL9iQV7y4mPxpHmJr3VzYZnW1j90cn7P9sXqxS2imJU7dflsgP9jCR15rhQPmYyAwrrlAjINbgz5IofR4J6pPi9S7KzX6/Fl5AoTMmzZIIiXIsjzIBS4E+imaqu0JUyGB5Yr4ztvCUeWLTYo0hiebfk6j21aFywbAUzMhGxue+U74WfFO/kJ97FiOg3zGgM+eEC553h8OqCGRrNJhTsGZtDtjzAloIYyhVQVL6VbfVtZglVBM7C9xD47Y12K4XDGcxXYNnx+DsY+BcBqxQrwoRwua/w/Azt0kZuyrry3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42RAJdOIdn3WlpiKE2PzJSRPiAiHL0Ua579av1mvcYg=;
 b=UWxIP91CFvJC0MX47UUC3PY3IXMcHMaks0gIcm+kX39GxX8pHl3d38bJBbb2UBwWTdVoeNPiZX5DD4q5ZGNuCdP7ie6clPIJlZGeet5fkQKFTV54Qi0MU6YWXRwjDK84JEf7VY/pEgjzeKFRHLomanvJDmcQ8H2iSB8g5k/j0WI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5661.namprd10.prod.outlook.com (2603:10b6:a03:3da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 18:58:15 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 18:58:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mike Javorski <mike.javorski@gmail.com>
CC:     Mel Gorman <mgorman@suse.com>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Topic: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Index: AQHXjKYRxKTFwD0+C02+ZMVduTdsB6tqSi4AgAAHiwCAAZhPAIAACtMAgAS9YICAAA1rAIAAA7UAgAMLuwCAAZFegIAAyYQAgAAzUQCAAG7RAIAE0AAAgAAF0YCAAxscgIAAOP4AgAAGqYCAASxAgIAGIIuAgAAkXICAACgEAIAAWTeAgAAMTwCAABHBgIAAdRaAgAAwjgCAAFHqgIAAHnMAgAA7fACAAPuSAIAK9LQAgACMDXCAEVWpAIABD7aA
Date:   Thu, 16 Sep 2021 18:58:15 +0000
Message-ID: <A4BF67CE-BD6A-4B23-A5E2-5B71EDEF0EDD@oracle.com>
In-Reply-To: <CAOv1SKANNnAQms8mGJzTAW4dDWTF=EeCWM0tQJNiGQ=7Jekqzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62cc854f-12fb-4030-12c9-08d97943f09a
x-ms-traffictypediagnostic: SJ0PR10MB5661:
x-microsoft-antispam-prvs: <SJ0PR10MB566157D564AD6D3A1A39BE5393DC9@SJ0PR10MB5661.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hkMPN3Ij6IsHvjuSUAyzkQDfLMYT2XyO3lzkwP3lvqr+sX5UENOZf4QucbL0w30Cr1ueKYKjltPTA8iUsVEdg4X7DQJRTZF6doYLK2lnyMRxsXJJnV1jQzAvMPubAAvM2rP1KTc1pt+q+YGolAjvWPD4qvGs+ExyVu5e9ipqn28FGJyrwbMrPyJ/DcaNxWpSSmXQwu3D79pJFwuvqpM3vsnJ3ArcSKAz2iKkKPggPgbck9VVk91QyyunuPZsLIQ4yo4LjXTmVi8cW+F7PoQX21dvxzuuqS9oQ9aeChOXCEggf4kaqFWXdTV0Fh6flBNS1Vb1yqvGQ70UbCa6fu/TAFPJpQCazBA+yT62BznWcMBF5ocHvGePQ3LIaOfjfSR5kR5h41NtP2MVazr2E9aJSQ+vpb0lBwCQpb7WXgTU1hFwH/urf67OWPsckNUlPJRTQoMTRP+HRUBPcjqhUexIAZDCYe50UbXaF/61eycVGb6jOxoLYVLf4SFdM0ELiiy3jybENHv5CbuuNcop0059D/q6WBKLJvVqv9wEnh46AaYvCBbMYorAFlzv9/qU3B0SZuKKhV4Sx4MstAl8kvAqsOwDcJ17f0RAAwLLvUgmRogjLtsTjDYRuAL9u3nu5V2n2YA+ieC6a5DMSqQmePctqlMQ19GnA4XHgeFcmEkl8AzFk7vCQ/ujjizvGUJ7IvUZ57wqPeSl2aqsT922Uofc6HDLPchs491smq157ZobZASyGED6hyHL/2LFP4WFccIl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(38100700002)(5660300002)(6512007)(33656002)(122000001)(186003)(508600001)(8936002)(36756003)(83380400001)(6486002)(316002)(4326008)(71200400001)(38070700005)(53546011)(8676002)(2616005)(6916009)(86362001)(54906003)(66946007)(91956017)(76116006)(66476007)(4744005)(6506007)(64756008)(66556008)(66446008)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LOF7x/tOl/xFK0OHWz3ijViZgH1+b1p5ntWwqksAYhX8aWU9NRhvGaz0/bJ8?=
 =?us-ascii?Q?pq1/GLmQ10AdxQHc/6TMkct3QohDlZeJvWnBztjnmrR7eZfNlhNeTIzvd67Y?=
 =?us-ascii?Q?kSMSp9Bpbi0eV8A4A/Sahpt3LuXhlT/ODeeR7PW0gFU9FF2JzjsqSAK8RGTr?=
 =?us-ascii?Q?43MSdXkDWpiBRJIECAtAeAqcuebfOtw8f2Lqt/MJqR4jutvtOMtOR46OuqpE?=
 =?us-ascii?Q?vu9DcpvRc+XmcQ821RVfjoGx09A/GxPkKBt3TuSM8zUbzD5Jr1CYrgSBK1JS?=
 =?us-ascii?Q?blEZZweYyRJ/zs3aWFpjHLrqe4C3eo8BDaekC5LeuC7spWZOWmgIDVD06cGi?=
 =?us-ascii?Q?v+XbYvQVv4PnZRYcIjDp8fxDcp5LbLHhGplAGYsqBKmJJjnx20SqpyVGpV4m?=
 =?us-ascii?Q?kVijzEZNY2GIk19v9k0dnPepbBHU2+gndSB5Nop1ysdQXONwABulkQJKVxMf?=
 =?us-ascii?Q?9qlZKEuADhxnaHaEWvSuw6f2miPN9TTcp/myN11sbsPzkZ3c9bOew8/YWqKv?=
 =?us-ascii?Q?vqIMmz0tdZxRGNhM7HKpZ/kMeAP35l7OJIkargwWqrVrWYlNfmsORyAy+Q54?=
 =?us-ascii?Q?qD26UA4KCnFHyUQpCqL1GMxpj/MobcaVb6j/avC4FEbCl7U01ye02TwZtuIU?=
 =?us-ascii?Q?U98y7xVNOWDrPD5l4W8ldASr7KPH0/D7KMKb5QmcG0NS0Ae+gejCLgtk4lPA?=
 =?us-ascii?Q?TjQIHK5vbniqHaBzCTZ2XicYE2mHdVeXQpnbUDFByIVysHxCw35pUP481deT?=
 =?us-ascii?Q?wGT1PUPFLNb7PQ7YuwVG/yK4GQjxU4A1sopaY9zMJba+Rcqz0ogw+X9Ir6O2?=
 =?us-ascii?Q?eQRcRxNC0aaa3H+qYBHtr93HLSdFsaeoV6aXkTHDGosKOU0hCvR3gsoquiL6?=
 =?us-ascii?Q?DaKhifOybZ8wANPW/bqP+nt1NKWE0fGPQZBv1YNMLG+UdxMlcj8c30+gFKje?=
 =?us-ascii?Q?GmAT4iNjGuFouvG0FCyx8UWe7JFmswbYwaqh2vJXG9g0JnMy1N1TLPfvuuyr?=
 =?us-ascii?Q?byEvmz0S9dWra2Fr2uJKKlbHBdc93utff2kz8KGf66nImR+3ZrI2I40M0Pds?=
 =?us-ascii?Q?E64WngWv4ggnDiXZmvV9h2+00AMOeAfsTLry5nlVTTmmYFIZ9adxs9Vfe/6M?=
 =?us-ascii?Q?AWxxc9rt6+wC8SFAHslQxCbPj52XL2EyEs5VGUN9XptMXBylKvcaZ5aMPup9?=
 =?us-ascii?Q?dK3NrXIbCuFVXhx1rAX5HcdJj6Ea+I+FANEBoQFnF/y/Q8VDx9JneeATXrhq?=
 =?us-ascii?Q?SHm3mUFKjcTG9fNmeZmae6AJs5SJjxcQ5bGwMv2ExdtKxavD6+f8b0tiuajt?=
 =?us-ascii?Q?EO1uu85uD7wgb4w24wtNVejS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF76E98ED22D3B49A53B77515CE36396@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cc854f-12fb-4030-12c9-08d97943f09a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 18:58:15.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwTCj8vOLtYOWEUNBRN17XOQdROBrnIdWo+aGtl/HSVWBcrIT8TKyIv56dAE9xGfPekczvV7pKjKATVSdpZLmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5661
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=923 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160109
X-Proofpoint-ORIG-GUID: -Mt0RKVALpgY4RiGu7A_Pcr8cxDePZnB
X-Proofpoint-GUID: -Mt0RKVALpgY4RiGu7A_Pcr8cxDePZnB
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 15, 2021, at 10:45 PM, Mike Javorski <mike.javorski@gmail.com> wro=
te:
>=20
> Chuck:
>=20
> I see that the patch was merged to Linus' branch, but there have been
> 2 stable patch releases since and the patch hasn't been pulled in.

The v5.15 merge window just closed on Monday. I'm sure there is a
long queue of fixes to be pulled into stable. I'd give it more time.


> You
> mentioned I should reach out to the stable maintainers in this
> instance, is the stable@vger.kernel.org list the appropriate place to
> make such a request?

That could be correct, but the automated process has worked for me
long enough that I'm no longer sure how to make such a request.

--
Chuck Lever



