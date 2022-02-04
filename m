Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2593F4A9F6B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 19:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377785AbiBDSpm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Feb 2022 13:45:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377770AbiBDSpk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Feb 2022 13:45:40 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214GT4Sd011211;
        Fri, 4 Feb 2022 18:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1r10PtO8fehXmVaY8+yOfzApiY6ojytZFow8eFn0Ces=;
 b=0h89vZaTzdb5QLOd5OdtPPbBu7zEgOQOCjcS+uspYnv5OngshVRx4yyijLxWu/0VRmRl
 4dnSHrl3Ul3r2RWLgaMRFxItGqQ/EqVdU9UZwgg5Wr84TpKKZEasmrOat0B4SrKE8M7N
 HdLQuvJ4t30OYAAFn3CeLQVYpHhwXbosK9PKV7kXGVXAUdWkIK+1U8r93LYSPzIqU+rh
 ESzr9Ux80uw8fv53oZc91kT7PBZvuEU/AxKRP747byPvpC+pB9WyOc4PWEgvvzZtd1li
 hW1osvj5k9E8Z7BxTjL7ll7uKJ4HKwt5u1V0qu9JxJQ0NSOet9OwfcMIXUeSws0oIp+k IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hetbje8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 18:45:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214IVYOo046282;
        Fri, 4 Feb 2022 18:45:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3030.oracle.com with ESMTP id 3dvtq822wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 18:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTqdjeqddU+umtt5grgriYyqt6ic9dpB5Ss3raY4L2aYkCQJEnzWbcvPsjOMVs4mxrG3a1QIxrK/GUSZvabGVKLBOhfj3BEoRHqxzewrJd+jimpsI1QubYBxCt3wZqA7QA+QH/iCdgG07bxJTIFbAKaE05tsqW5hL7FhJliS6v5QhoUw0HboYcriGfKLuo4jOM+q1kzghKD7S4rV3U3YffFvMqHNYF31KYTiWDnGEPD+Bs4d+WsS2qA2sr7FRmvVTuC/xUVRIf9GI2ESoUtFOp8Uc6Krmlis95Vtf8EjzJUhs0rw4CpSJgBxrTB52Kd4TWW4bOL02bN26lXleJyBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r10PtO8fehXmVaY8+yOfzApiY6ojytZFow8eFn0Ces=;
 b=kgd5hIKZ0QnYQfViPRHtyYuTSiRC9Q/MejtmZ+XWivRMFN6sXgm6ZvUf9l+vhvsOSSdjYeYo8vSaZkYR9igKwU+mbhUESkgRUOsckEIqNv4OmYcEcrWNcIo2iAyhM+Gfu0IkxNa45qDsm92XZFOZgYNwxUSE6nn1g/dOguxNbrtLIyU9ZExAEENEZT95AzAU0dbOOR3TNBoAeRrXJL1ejiNpYr/53Avb8h8tuP+Ysa0yp5WFJAsjSUMyHGVFjLghB/l4JJf0lMBDsASCV8+Bx5BnzY6jnhDSxGOhp8crWjTQNxXM3pxRfHGF8NivDRgNOBdjmn2/qice3r3s9EbRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r10PtO8fehXmVaY8+yOfzApiY6ojytZFow8eFn0Ces=;
 b=N6hk+CQ+qUs4h3KjzgEKXJvuXhuO19BEUzzVhvvJZ8h2luj10M6GfnBaDho/44YC0k8nqd/WH17yEbCN1zbstBGnEHyPDbAiCECfitZJ1aHWHAwIrWMckCt5UCIjvVEEI0tIR+7ZMJvd7FBThdhUtt3jO4utsCSoWPBw2SgoMQA=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 CY4PR10MB1848.namprd10.prod.outlook.com (2603:10b6:903:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 4 Feb
 2022 18:45:36 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00%5]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 18:45:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Topic: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Index: AQHYGca9ZpW/pPf5rEWUIwyc/qfEDKyDgRyAgAAI8gCAADEtAA==
Date:   Fri, 4 Feb 2022 18:45:35 +0000
Message-ID: <26803BBB-4F2C-4EFD-BC8D-A50A5C361E5C@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <87EAC6F6-C450-4642-A11A-55247C791D66@oracle.com>
 <32889B9A-1293-4050-8131-726042D1EAD9@redhat.com>
In-Reply-To: <32889B9A-1293-4050-8131-726042D1EAD9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4095d105-cf08-4106-6de9-08d9e80e87f8
x-ms-traffictypediagnostic: CY4PR10MB1848:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1848B660E934E7F3003B099893299@CY4PR10MB1848.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ulOyvwNi02UlWHOcmCYlbLdnGgbky/GdeXn9qwIRGzIxr/7PMi9QNPJYRhqOKHaLrct4YDpYAmZVgZQMMiYD8hQyRstTEHzO6brPbRyDY+Dk1u6qI6MpLCyNW0jo5vUnNSTY2xIPvbq9yroAzfQe2izd6PoKlRpEX/360AgDom4XxAEZuJ4A0dontNhCO6y+PfzJmY5oop10wrPCMBLf/Y/ZyOWhDYyRXBXTgdXqk88RnUr3ODwx5V9Sy7snovEJE0KzlTupUzwNUf2iESvd0MoE0+KiLk2qlKgvLTcqQytZU8kreNQskxcmga4oJy+NdsMWNZ52m/snpBkuvi5BTgdmevfj+Rec5JCYM4ZcHL7/fh8Kapm9je/V6cuS7MwU9GyDOyzpop+fEXop/Lg9EnbuXIa1a8G4OFp8Kfuj6MEkXEY9X1zPTf7EAiWk44TwNfhLXDAWdVyS7SMS44MEFQ+naBNzhFlRoC6LikOmDnUvgY9JUnpMxYCgNO+aRyZX3hfawQ2TclT9dQLys7DhDcJ0TTXzenCk1cZu1ofGhEINvKbN4kkk8OGeC1C8G4C5qkCfqMwDoIFBhA7CiFyOkrR/Cy1gMyT5vs7DlyKP69e+u44LfItfHg3xgHtN+gO4xw6zVwnB3oHbVcpIbUyFTnQN8VlI/tFJroUG5Ly/6qTwmvSIelEEDPYJb0E5z3+rlyqkjEOgPWYLTkH9sfjRHj4hZjmowdiinYsrkAonfZDsUeoVXsw+it6XHWlnaqtwSaF+NZap3N8TJ2A3s7g5Nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(316002)(66946007)(91956017)(6506007)(186003)(6916009)(26005)(71200400001)(6486002)(508600001)(33656002)(53546011)(54906003)(76116006)(6512007)(86362001)(2906002)(122000001)(38100700002)(8936002)(83380400001)(8676002)(4326008)(36756003)(66476007)(38070700005)(66556008)(66446008)(64756008)(5660300002)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7+kgAkC9xBW2uVrrwNAUsR8+Bu8AnqsA31Glx6PU5uHzPGmuMJfLFEf1nKm7?=
 =?us-ascii?Q?XGv5Q50shMmhqq8hoOVQLVeG5IZ73Q57CeO2GHO/4bW4+GCNNYQgvxL4qtYm?=
 =?us-ascii?Q?Uzij03kEnIH+8UD3jHmiMvB1St4pLrlsckm2QoQ17R0C4QFZrL98wpmhIK4p?=
 =?us-ascii?Q?peAd2V173pTXSR3pyg+PReOswAQM+3Ag0gFTesuFAVgNYZCksXQw+Sj+40nH?=
 =?us-ascii?Q?E8wN6pMOjMShzIV3DTPi+n1rEG9Nq2ducOILOxjDPdeX75dGLCwiFtLJuZ5h?=
 =?us-ascii?Q?2JV/cjK0mj7qqLwUHbGld191fm+M8oIhpyFTKAnZbMT9SA7jrBEhpoMwfRvC?=
 =?us-ascii?Q?vpG7dlkdhgF/7Pg9NUztp2/zkzOhrxIlNZzHvCoTfGyYnlafZosUP1Xn8GaE?=
 =?us-ascii?Q?vVkvKj4rVUp9ofjWFQiQ3pxH+DWKLTrdoe0D+QtRCCLFtuxmjw3/kDajENcy?=
 =?us-ascii?Q?WtDRYuOP731oYs2w92J7pfeeagtntkfZ5hA4LmJO/xI6ok2at0wLkbsQcYW/?=
 =?us-ascii?Q?X3sZPYlYEAuV5HfxoB5OjApWAyy1SqVcLTD3K5aaAasWOGvggMGCg3lPlJdO?=
 =?us-ascii?Q?nfeVlbBMlupRbH3gjuYDCFUoGuU3MFJmnOAAE7FTB7WpKZbIwAplNa9cPXKc?=
 =?us-ascii?Q?MbxpgVhPEnuV7buB6yz01XxwUzmSmX9HNbAFWazivDKaoxm+0dqOtfuQjcM6?=
 =?us-ascii?Q?Qq731IReAtRBg2/hWwPcG5CmnS8Nr/3rESQ+xNexkw0ewq+ZhTaEwOHNd8Ea?=
 =?us-ascii?Q?WbB/9fbY9RdmwFbhKCNZS2P4jG6q0sB2zx3kiKfgC1Mn55rrBjskz8R38+lg?=
 =?us-ascii?Q?Xj56+CquVB14+uAsaINbxLTbHdU2qWicucCqsSv1MKl72Uppiu7Y8im9+0kE?=
 =?us-ascii?Q?VoHW4eLQQUHzh3Y3fuNzFxqSOWk3wcsJ8ax4MI6XTdpRxTUAa7MJUIImX3GB?=
 =?us-ascii?Q?QETlJGJa41s9B2YEJ18Up86lOkoStAZpWgZM6qH9YgJrsvRuNgHIQAvjfbds?=
 =?us-ascii?Q?piLIR9zJBskG1kfUg0wBVAheVOCKVlDOtIWAgWlYt/VBz1+dke9I6v5zlEAG?=
 =?us-ascii?Q?QT5BBW+BpHOG3eVeXgQ1TPdJmcz7jFOji7roQb3Vbv+5YYLTCitHMG+GhepW?=
 =?us-ascii?Q?xf0dwPnTDNxLTzPuYNKIdc5N9jPpjVQEgCUHdhrUYuCSnmjNQCR2iwAOeIXf?=
 =?us-ascii?Q?adxH5Mv7qnFHRrbMSLe97kNrwwpDfmHMy0e4aXEU8J088e187FYVwNcOqTED?=
 =?us-ascii?Q?Ss5Lg1dqb7cZyEY2yKNVdGJ48oYr5t0Lp6gml52fkHjYLPe3gjJbQ37yPsGo?=
 =?us-ascii?Q?4ngSb7Rg6Kp/KUZFnn7hFlr06oywFqDRpzoLNHZppAlH8XV2G7vlIY/Oe6t8?=
 =?us-ascii?Q?WwPQ88rkbviymJaWeN382hx1Fz7bqAPocoVnbcl0UfczYIr0cQllqu7Q+x4w?=
 =?us-ascii?Q?XruQsDrY8X/xn7VQXb/4q4M1OAdoQ/rW/Tc+3mONqKEMEG0i/MYjgZMkl3+0?=
 =?us-ascii?Q?kls9ltfFKBilM10TcjM4PWisLl7R6osS8uHVmXT5BuD6Zc+WnMFyblwiKsko?=
 =?us-ascii?Q?d2kc4P1ksc82r0FVAdN9JUMaSFVWf0JupoCUiMEfYYZf9kdRKrmsTIixVX/W?=
 =?us-ascii?Q?X8g1TEajINAY4tp1Weo/Pt8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C2C56108D866E4589C9378F305D02A1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4095d105-cf08-4106-6de9-08d9e80e87f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 18:45:35.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dO4KfkKgh0NjN1beGMiseC/nNKjvzLpiiYuWZIlHOqwID6iCAhbkUqjCMXDV0IKAfURW5mWbD3IqSUkA6h+b3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1848
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10248 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040101
X-Proofpoint-ORIG-GUID: 9v1TXtI33NCfx0BB-t3RRnKOxnav7Wzi
X-Proofpoint-GUID: 9v1TXtI33NCfx0BB-t3RRnKOxnav7Wzi
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Feb 4, 2022, at 10:49 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 4 Feb 2022, at 10:17, Chuck Lever III wrote:
>=20
>> As discussed in earlier threads, we believe that storing multiple unique=
-ids
>> in one file, especially without locking to prevent tearing of data in th=
e
>> file, is problematic. Now, it might be that the objection to this was ba=
sed
>> on storing these in a file that can simultaneously be edited by humans
>> (ie, /etc/nfs.conf). But I would prefer to see a separate file used for
>> each uniquifier / network namespace.
>=20
> This tool isn't trying to store uniquifiers for multiple namespaces, or
> describe how it ought to be used in relation to namespaces.  It only
> attempts to create a fairly persistent unique value that can be generated
> and consumed from a udev rule.
>=20
> I think the problem of how to create uniquifiers for every net namespace
> might easily be solved by bind-mounding /etc/nfs4-id into the
> namespace-specific filesystem, or a number of other ways.  That would be =
an
> interesting new topic.

I don't think that's a new topic at all. This mechanism needs to
deal with containers properly from day one. That's why we are
using a udev rule for this purpose in the first place instead of
something more obvious.

The problem is that a network namespace (to which the persistent
uniquifier is attached) and an FS namespace (in which the persistent
uniquifier is stored) are created and managed independently.

We need to agree on how NFSv4 clients in containers are to be
supported before the proposed tool can be evaluated fully.


--
Chuck Lever



