Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA2B578BDF
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiGRUff (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiGRUfe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 16:35:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F082FFE6
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 13:35:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IHVde2024475;
        Mon, 18 Jul 2022 20:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=q8N6bTpCkEVUtwfb5GzUW29w0iz5xamcQ6ehgTDOIf4=;
 b=xf7ENjdYajWyAMqJ7oQTRvPNzZSxtYpU6aVkj0m5on5Ilao8DmhvBY4dpHeLy+2ydE64
 7Qht0CepRbYbr44hIiWpjHVjaUxYcHZC9o7TkREz7b7lN9XkV/3fdxCe/YEOilB5vpIh
 ImHsfA7KKdS6ZdcUQlN+ssp0rpEq/vVq7mGEz3foAmZIcntXKKBkVi226tBCr5QhJFQh
 FTeKNFDyBInzQc3v/9GTiySwzuCj55OGGVeMZGvLxfVTlCQxRlcLKEdsMwwifVy4iIkw
 xOuFVAn0gXJDK9BbIZjghCVL+FDKt+WsofcN5fos5nhbB5jDngmCr7zxQ7ucQIxZc6MD Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42cfg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 20:35:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IJ5fFn002026;
        Mon, 18 Jul 2022 20:35:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k2srbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 20:35:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOcfxhUInDuQG55ZNGe7BgsBJKojk/FGMSqZI6Pnpb/gN5kJQaWYbsPggX34Q3+8s5tor2efoh84cTegab1yG5iZlkfZ5hxZ/0tTFG1OVgX98BmI572jWTZ12oWA5tT+21ZmyHWDZzMC+GLaMuyFu6EuXwwyzhVPPpF09pNlFSes93seXQR79sTfTTUTkILXctGFCgAQ1I7+3sv8sY5zvw9c/o3izPWWz0T3TzD5oRbxp8pZyxH+g9u0opJBFPVYUAI8L1TmBGR9YeE1GcfLUPSbiBDdGdEdySi/WzrRgMf23SNxzjbPN/JvzDumeDFrj/MHlyRHc4AYHTRodh7yUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8N6bTpCkEVUtwfb5GzUW29w0iz5xamcQ6ehgTDOIf4=;
 b=JBlJGfssUGjZR5Up89CkgZSfC2GFbkRn/wklrDbsrQoIeJiFA9dYic4NGEpVsHKgJ9dSHkjqGyZiK4i7joNBhOBZmjHvcKk06yyn6xmVeffXuDE3kcktYmT28X0ZbKV/PcT2u1PVondGLW0bo5xwOIEggmkGn4iw+kN+wR1cnDHAW+mGYyrHE2YOqKsAEXlVxHPOck/8rvCk9G9oyCAa3LkqJ6Ih6wNj8aPiZ1EQPtDqJfHSpuZy38HKkNoMpuaaH2EwtNaKZYLSLUSSaGYmV4Js8SzKL3WKcczt9xqoVGkyJ1V10jnLDXhOpkBIpt1Bz1UxQOk7yOjeAW+8kp1bTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8N6bTpCkEVUtwfb5GzUW29w0iz5xamcQ6ehgTDOIf4=;
 b=GWjqCIlQVFKZfHkF7CYp6TdqBnFA/L1OWT+0+9uaz2rXkncmBtqs+nxjXM2ukrp16tZud2g148NYXfXol++I1GAFcWMTq4KQjY011gll9ttCGRrymlW4xIYifeBu6EQhbWlEoqANyj8EkuYDSETRarfyt7087Uyw/7Nszx8iWN4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 20:35:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 20:35:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@poochiereds.net>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2 15/15] NFS: Add an "xprtsec=" NFS mount option
Thread-Topic: [PATCH v2 15/15] NFS: Add an "xprtsec=" NFS mount option
Thread-Index: AQHYebV7RA2HrkaE3U+wjUZg0SUNjq2E1UsAgAADG4A=
Date:   Mon, 18 Jul 2022 20:35:26 +0000
Message-ID: <17CCE10F-6E56-4F11-B575-55E169DF7FD6@oracle.com>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <165452712574.1496.3911067710891054200.stgit@oracle-102.nfsv4.dev>
 <97306a9fb52c0f5cd37b27817c901f4894298bcd.camel@poochiereds.net>
In-Reply-To: <97306a9fb52c0f5cd37b27817c901f4894298bcd.camel@poochiereds.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c34737b-8ec0-4849-3e49-08da68fd0c38
x-ms-traffictypediagnostic: BLAPR10MB5138:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGoRMzMlfv8XMtQP0aXcd6uPYtsc2b+u/zCwe++umjIrm9yWv71iWNhiUtPsRztJorlOPWfIYmQeyNPTG7hRPvq1Qd+6W+5FEnIPnURyaPgqBnm7/G9rpYdNQML7XVQpRNwqDKgIvBWsDRwNW8jIYAony4NQ0EZSG0zHq7hyrgD1Zqt6EdPzml/Pk24AyQp4vPqB0A7nzJKTX/fodhGCY5mYVdWadk2h/xF1A3Odoy0bsERXr4kVdJHY96c97/wBRI8qEQnEf8nsI2Bd6WEGb30kkyrGfnqJOu8Z0Qd4KuQO+bUTAXYWW5tZ509Qdn/q+d0x1twWP4DPsYE5Umkye8C9lf60i9F5Z9LQe1G8Pnc685O8NHbZUWOzMW5MZ7dkQgBKUXQDGCgvgOvIgrDUtk8r6EW8idbbMZoHqBBbDGY9hE1oDw+lEQCNb8NEwnOVq/iXHbILBuw7Z1JtHMVvfNpElvAx8pUp5aolrVpOO8uJbDC33ADbORtU65/W1O7Zr5GIPbZJQXb7Uryf4tT8WPui1xz04MaRKIvDW6/XR9RIDl7nnFCr2RfJM02raNSoI1sISURR/YNzgzE1DW/RLQHVmtPKIWvJQVKcSgYQn34ixlhmj8h5gOAeoPjMFeGBxCdOlouSuSLoxAES9akWftuX68mD20kGzpIDg087gqfnRQQeGnnaJseP06ot827v4QxFjpLnZuzGKs02WK0sZR/enlg9qev8DfN/uOPV8YKfR11Is7sNNYeAAMgLJ6PSiHnpIh8RLYSEUarD4/cqyJkGhXCXQBC/t8pm3gRUWFOvvHoGSlzRThmk8JYJeXUBXvoO484LdKMczIwPXRlOJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(366004)(396003)(136003)(6512007)(186003)(83380400001)(26005)(33656002)(2906002)(41300700001)(6506007)(478600001)(53546011)(8936002)(6486002)(5660300002)(2616005)(86362001)(122000001)(6916009)(4326008)(64756008)(66476007)(54906003)(71200400001)(8676002)(66446008)(76116006)(66556008)(316002)(36756003)(91956017)(66946007)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lsL+YYgG2TxJJCgwnh2y8sbwjp3xrtFidf/FoPjkhOYI/8mi0IzHev5v95SZ?=
 =?us-ascii?Q?1Ks6LYxGtLIHK7d+1bZuus/9qvCtYZikuVYahnuZKYDow2k3udf1eA6kUVwF?=
 =?us-ascii?Q?PKbRqrbhWF3yHYVw+4u7NF9dcQ8Uc+z3KzsU3VNymL1VfF2sYbWMOK6QQ3wb?=
 =?us-ascii?Q?FANG5C+gJ1+QL2o+yPGSJHD+HTza2VJ7EorUjInapTz+5ItBc5qMO67b5wu/?=
 =?us-ascii?Q?hHOx82IANs6R6OtY6LWVKED0gTuF/bldJ4bBf4R+OwzVtEoePX1GupBo9lux?=
 =?us-ascii?Q?pDrKvcXsb4bo0XBUXuwkNzxCZd396WzUDot2t+sR4JEcA1PgFoqQxJF8LoKF?=
 =?us-ascii?Q?mQ/RLgOd8NdtmonlvxQ4VUeRg8fClMXs7Y0vhMXcP8DKrVLbWbPHFmCdmGHb?=
 =?us-ascii?Q?CXZZqv1A1GLcSk754MfQkzZjRfI69dOtas36qUMHBEajf37PdIYqH7y4M91z?=
 =?us-ascii?Q?il7//OvXcK8+GjObyDDpqkE4XSMjIWAR3TpCoBFIENpEQRgiFDpkFI7O9B03?=
 =?us-ascii?Q?WbBAfbHA1sAfPETVpVlOnpEh9c7ZUuY6eK7QwUZsrCk6VMjRJi+MFKK5ZCJ0?=
 =?us-ascii?Q?zQTUhRmPq3TqBuOuPJespfjjulRPzLILoE7Y1o/GsJSPVlaYO+ZXqJCUAb4d?=
 =?us-ascii?Q?q1bG3MT9IDLgZgmUHmhWTF3VCct7HkT8+T2nNHAmBzY/5brczJIk7vPXHy+x?=
 =?us-ascii?Q?Bi3wqon++Qk08FKz1wDiQOq10dAFjFX4hKMgGvqS8lvRtKn9JwoxN+2bItr3?=
 =?us-ascii?Q?fKwwsioWZJxmFMtnRsIkWoq7iSlaRKCJNfkgFPMDr93Zob9zoymTBtsQe1ZG?=
 =?us-ascii?Q?owVsJ/eOQfXPcvjvES7yOy10NdiZOcTC0QM9zAU7DM5FiK1/Mxtc6LwqXtvU?=
 =?us-ascii?Q?D2fy6LwuySqZ9C2esjPTj3WtLGGpajFdzlBlkKOZlBLvdQyt5S00tfJfyKL9?=
 =?us-ascii?Q?0Mp43/bFFabYVgc4FpdAJgYRhPHHptgLr2ozOCGwk+RDT1eFVgld3PZq7Ugw?=
 =?us-ascii?Q?UuXOtlz2DZB2VeEsb/nz2UYFg6DQeKBBwfzCLcZBg6oARARMDMvOsQ/ZgER0?=
 =?us-ascii?Q?E8aDEBXAyhsYZSEWd+xWQfdMOpySGG9T/IcxsE0aFpia9Hm3rZ1np1LYCqck?=
 =?us-ascii?Q?AwimwNGHbunuqU97jtL1V5I/GEKm/VK6xt97wIHDEBUs+4dYEM6zDhoU9H3K?=
 =?us-ascii?Q?nN9W5MWvhBKOuwL/vsk1TRX9CErY5nVWiI8iKu9t4zWObcRCtg9U1C7lpEGI?=
 =?us-ascii?Q?UWEZfFH9IvvIDo+EIAH96ZoiInIGdnuSrB6Zivj6ZK64GxhoP1R/f2QxB95V?=
 =?us-ascii?Q?uApowoTIIVYl3HEn2I7E8N/ulJiT5vZpPTsL7c9wRbTCFegqaGTQhyGocNjN?=
 =?us-ascii?Q?+Fu/ZeZDk66JuEoTzUL1MYjuS5fQ5YLeLOW9uZedkmo1Bxe+BDFKdZ8ARCl+?=
 =?us-ascii?Q?EQ1hk8fDRFAty6EolDTzXaOo7TxzVRu0pq0eKPIoyxiu7YZb7Tgghot7LGfF?=
 =?us-ascii?Q?tsui2DGWZ1y72mNTBY0f4fNXVGs6M7PfhxlkD+PHXJ1SECnIY8ZlNNkoIA4f?=
 =?us-ascii?Q?MMViU0fxcusj7CTCUZIH3N+zC/w6j0CeBmxnPNNmHcOdgQzIOLgfSiBuhhTZ?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <719D215D3612364FBA8DB3026C9BCB1C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c34737b-8ec0-4849-3e49-08da68fd0c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 20:35:26.7217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWgU/Z4Cri+Ls2pOeWi2YIVXhQGErVVGXi/89U/ySIkScb8lUE9q86lZZVTyqnk4s4Yc1ws33ZoE3qspVVrWmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_20,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180086
X-Proofpoint-ORIG-GUID: LEelVJy7ElBpaOsoo6ucIeW9MbOWfMsQ
X-Proofpoint-GUID: LEelVJy7ElBpaOsoo6ucIeW9MbOWfMsQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 18, 2022, at 4:24 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
>=20
> On Mon, 2022-06-06 at 10:52 -0400, Chuck Lever wrote:
>> After some discussion, we decided that controlling transport layer
>> security policy should be separate from the setting for the user
>> authentication flavor. To accomplish this, add a new NFS mount
>> option to select a transport layer security policy for RPC
>> operations associated with the mount point.
>>=20
>>  xprtsec=3Dnone     - Transport layer security is disabled.
>>=20
>>  xprtsec=3Dtls      - Establish an encryption-only TLS session. If
>>                     the initial handshake fails, the mount fails.
>>                     If TLS is not available on a reconnect, drop
>>                     the connection and try again.
>>=20
>> The mount.nfs command will provide an addition setting:
>>=20
>>  xprtsec=3Dauto     - Try to establish a TLS session, but proceed
>>                     with no transport layer security if that fails.
>>=20
>> Updates to mount.nfs and nfs(5) will be sent under separate cover.
>>=20
>=20
> Seems like a reasonable interface.

Note we are trying to keep the administrative interfaces on all
implementations as similar as is possible. Some of this may feel
a little non-Linuxy, and that might be why.


>> Future work:
>>=20
>> To support client peer authentication, the plan is to add another
>> xprtsec=3D choice called "mtls" which will require a second mount
>> option that specifies the pathname of a directory containing the
>> private key and an x.509 certificate.
>>=20
>> Similarly, pre-shared key authentication can be supported by adding
>> support for "xprtsec=3Dpsk" along with a second mount option that
>> specifies the name of a file containing the key.
>>=20
>=20
>=20
> ^^^
> We might want something more flexible than this over the long haul.=20
> Container orchestration like kubernetes would probably prefer to manage
> this without sprinkling files all over.
>=20
> Maybe we can allow this info to be set in the kernel keyring of the
> mounting process instead of requiring files? In any case, we can cross
> that bridge when we come to it.

In the prototype I'm working on now, mount.nfs will read the client's
certificate from a file and use add_key(2) to inject it into the
kernel. It passes the serial number of that key to the kernel via
mount(2).

During the TLS handshake, the kernel gives a connected socket and
the key's serial number to tlshd to do the handshake with client
TLS authentication.

When we get to the server-side, it's likely that rpc.nfsd or
some other utility will do the same for the server's certificate.

So we do indeed plan to use keyrings for this.

Meanwhile, if you have some specific recommendations for handling
the orchestration requirements, or know someone who has informed
opinions about it that I should talk to, please hook me up!


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfs/client.c     |   10 +++++++++-
>> fs/nfs/fs_context.c |   40 ++++++++++++++++++++++++++++++++++++++++
>> fs/nfs/internal.h   |    1 +
>> fs/nfs/nfs4client.c |    2 +-
>> fs/nfs/super.c      |    7 +++++++
>> 5 files changed, 58 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
>> index 0896e4f047d1..1f26c1ad18b3 100644
>> --- a/fs/nfs/client.c
>> +++ b/fs/nfs/client.c
>> @@ -530,6 +530,14 @@ int nfs_create_rpc_client(struct nfs_client *clp,
>> 	if (test_bit(NFS_CS_REUSEPORT, &clp->cl_flags))
>> 		args.flags |=3D RPC_CLNT_CREATE_REUSEPORT;
>>=20
>> +	switch (clp->cl_xprtsec) {
>> +	case NFS_CS_XPRTSEC_TLS:
>> +		args.xprtsec =3D RPC_XPRTSEC_TLS_X509;
>> +		break;
>> +	default:
>> +		args.xprtsec =3D RPC_XPRTSEC_NONE;
>> +	}
>> +
>> 	if (!IS_ERR(clp->cl_rpcclient))
>> 		return 0;
>>=20
>> @@ -680,7 +688,7 @@ static int nfs_init_server(struct nfs_server *server=
,
>> 		.cred =3D server->cred,
>> 		.nconnect =3D ctx->nfs_server.nconnect,
>> 		.init_flags =3D (1UL << NFS_CS_REUSEPORT),
>> -		.xprtsec_policy =3D NFS_CS_XPRTSEC_NONE,
>> +		.xprtsec_policy =3D ctx->xprtsec_policy,
>> 	};
>> 	struct nfs_client *clp;
>> 	int error;
>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>> index 35e400a557b9..3e29dd88b59b 100644
>> --- a/fs/nfs/fs_context.c
>> +++ b/fs/nfs/fs_context.c
>> @@ -88,6 +88,7 @@ enum nfs_param {
>> 	Opt_vers,
>> 	Opt_wsize,
>> 	Opt_write,
>> +	Opt_xprtsec,
>> };
>>=20
>> enum {
>> @@ -194,6 +195,7 @@ static const struct fs_parameter_spec nfs_fs_paramet=
ers[] =3D {
>> 	fsparam_string("vers",		Opt_vers),
>> 	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
>> 	fsparam_u32   ("wsize",		Opt_wsize),
>> +	fsparam_string("xprtsec",	Opt_xprtsec),
>> 	{}
>> };
>>=20
>> @@ -267,6 +269,18 @@ static const struct constant_table nfs_secflavor_to=
kens[] =3D {
>> 	{}
>> };
>>=20
>> +enum {
>> +	Opt_xprtsec_none,
>> +	Opt_xprtsec_tls,
>> +	nr__Opt_xprtsec
>> +};
>> +
>> +static const struct constant_table nfs_xprtsec_policies[] =3D {
>> +	{ "none",	Opt_xprtsec_none },
>> +	{ "tls",	Opt_xprtsec_tls },
>> +	{}
>> +};
>> +
>> /*
>>  * Sanity-check a server address provided by the mount command.
>>  *
>> @@ -431,6 +445,26 @@ static int nfs_parse_security_flavors(struct fs_con=
text *fc,
>> 	return 0;
>> }
>>=20
>> +static int nfs_parse_xprtsec_policy(struct fs_context *fc,
>> +				    struct fs_parameter *param)
>> +{
>> +	struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
>> +
>> +	trace_nfs_mount_assign(param->key, param->string);
>> +
>> +	switch (lookup_constant(nfs_xprtsec_policies, param->string, -1)) {
>> +	case Opt_xprtsec_none:
>> +		ctx->xprtsec_policy =3D NFS_CS_XPRTSEC_NONE;
>> +		break;
>> +	case Opt_xprtsec_tls:
>> +		ctx->xprtsec_policy =3D NFS_CS_XPRTSEC_TLS;
>> +		break;
>> +	default:
>> +		return nfs_invalf(fc, "NFS: Unrecognized transport security policy");
>> +	}
>> +	return 0;
>> +}
>> +
>> static int nfs_parse_version_string(struct fs_context *fc,
>> 				    const char *string)
>> {
>> @@ -695,6 +729,11 @@ static int nfs_fs_context_parse_param(struct fs_con=
text *fc,
>> 		if (ret < 0)
>> 			return ret;
>> 		break;
>> +	case Opt_xprtsec:
>> +		ret =3D nfs_parse_xprtsec_policy(fc, param);
>> +		if (ret < 0)
>> +			return ret;
>> +		break;
>>=20
>> 	case Opt_proto:
>> 		trace_nfs_mount_assign(param->key, param->string);
>> @@ -1564,6 +1603,7 @@ static int nfs_init_fs_context(struct fs_context *=
fc)
>> 		ctx->selected_flavor	=3D RPC_AUTH_MAXFLAVOR;
>> 		ctx->minorversion	=3D 0;
>> 		ctx->need_mount		=3D true;
>> +		ctx->xprtsec_policy	=3D NFS_CS_XPRTSEC_NONE;
>>=20
>> 		fc->s_iflags		|=3D SB_I_STABLE_WRITES;
>> 	}
>> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
>> index 0a3512c39376..bc60a556ad92 100644
>> --- a/fs/nfs/internal.h
>> +++ b/fs/nfs/internal.h
>> @@ -102,6 +102,7 @@ struct nfs_fs_context {
>> 	unsigned int		bsize;
>> 	struct nfs_auth_info	auth_info;
>> 	rpc_authflavor_t	selected_flavor;
>> +	unsigned int		xprtsec_policy;
>> 	char			*client_address;
>> 	unsigned int		version;
>> 	unsigned int		minorversion;
>> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
>> index 682d47e5977b..8dbdb00859fe 100644
>> --- a/fs/nfs/nfs4client.c
>> +++ b/fs/nfs/nfs4client.c
>> @@ -1159,7 +1159,7 @@ static int nfs4_init_server(struct nfs_server *ser=
ver, struct fs_context *fc)
>> 				ctx->nfs_server.nconnect,
>> 				ctx->nfs_server.max_connect,
>> 				fc->net_ns,
>> -				NFS_CS_XPRTSEC_NONE);
>> +				ctx->xprtsec_policy);
>> 	if (error < 0)
>> 		return error;
>>=20
>> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
>> index 6ab5eeb000dc..66da994500f9 100644
>> --- a/fs/nfs/super.c
>> +++ b/fs/nfs/super.c
>> @@ -491,6 +491,13 @@ static void nfs_show_mount_options(struct seq_file =
*m, struct nfs_server *nfss,
>> 	seq_printf(m, ",timeo=3D%lu", 10U * nfss->client->cl_timeout->to_initva=
l / HZ);
>> 	seq_printf(m, ",retrans=3D%u", nfss->client->cl_timeout->to_retries);
>> 	seq_printf(m, ",sec=3D%s", nfs_pseudoflavour_to_name(nfss->client->cl_a=
uth->au_flavor));
>> +	switch (clp->cl_xprtsec) {
>> +	case NFS_CS_XPRTSEC_TLS:
>> +		seq_printf(m, ",xprtsec=3Dtls");
>> +		break;
>> +	default:
>> +		break;
>> +	}
>>=20
>> 	if (version !=3D 4)
>> 		nfs_show_mountd_options(m, nfss, showdefaults);
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@poochiereds.net>

--
Chuck Lever



