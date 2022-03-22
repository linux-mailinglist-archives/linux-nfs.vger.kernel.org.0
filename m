Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE034E4722
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 21:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiCVUC0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Mar 2022 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiCVUCY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Mar 2022 16:02:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D3A10FA
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 13:00:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MJ3vhe025411;
        Tue, 22 Mar 2022 20:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GbTUZl34ZuNxYgyxeLV5hiuY7WFWku6A3cffSv8qK14=;
 b=GUbA8yUQlXGG9PqJxLhe4tx4UQELIa3d0U0ZdpBFqh0/yCtKUg57pwJ/0E89/z3TTWgu
 Qxz4JB8MfpVUkGLSmWvii6HbKCaShp7h5zClKI4bGqgBY8UAfT3+pBiu3WYxE6fPRjgr
 Eev1dJrRkIlYv7encPq+QXjh2OmzDe5Ycr/C7SDjLZ8qiowLxCH5x43YckHuxT2s2PIK
 le9durTrFwvJTpfz2K3upSXsbaaYqkHgEcGrJeKb6pHL7yRG+hT1KefPuj5dfxcFE6ui
 lSue9i8AkMyvwjYpqM6AI4IBQcPAHR1qEdi78HsCALVxsKssZZKm62/F2TmgV38aZvth dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0qmhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 20:00:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22MJvIHI125617;
        Tue, 22 Mar 2022 20:00:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3ew49r7t55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 20:00:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg2DMFwPLK9+LGOn525sLHJTcc2jplAcvPOsLB/O/phbqhgtJyRaytwCuRsSy3zoDZ6ty+eRdyOqDOb4DiOhluMRPAwT9+Fg8Lulk727v9K7Yh7Br9MccHcjLxauzKpd2BkDs3OJ81Pmi3jAWI2JZvntRLjWCRBv9J//RB3ggm07fN4B8KmIu+YDVKOk/5ZQSB6YRiUWg1syNx9xudFdcateFS2V8jAW33ddM9rJnHwvsiUm/AeJPdBb/2KaxqahT+cd6TFhfw6mgTdq8HDT9JD9+ONd+VasSvJv4jAu34FKPxmBc/gQQp+rLyz5p5L0i5EYBoE6bY1eeskDwU9lkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbTUZl34ZuNxYgyxeLV5hiuY7WFWku6A3cffSv8qK14=;
 b=KeAH3Wl3Nq9G+Gh3OYBVJXSvzW5UKCn7yzk/1sQdNyF0tD9U2IBPV3zo/lYrNfduSGbBWYf7mrVU9v75ezxatYzP7noTrDj+pC+huFWNkqm9ZHUHE4epkC5o43qYexSBl+pDAtzaAsLrYSZoC/IzBfBxwcCBPwIiXTXQax3roYqCodYkxyR591YIWlQB+C4akCfeE6Sf0GjPY76s9oxm1AJRd3Vw9lhhUvDX/Poo8SGsQRLS4/RDZsBnZ6jhGJqa9mLzo6OEXmf/VfmvFc+6BBelPplmiGz48pPERZl4KteX9jXTZvCnKZBWNZZTKV8EePVcIaSy12jghvGHp7Dh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbTUZl34ZuNxYgyxeLV5hiuY7WFWku6A3cffSv8qK14=;
 b=Ats5z4ym1ED2kHi+OoZMLdoLuyxcTUdQrP9k+Ti6tTaaF7NKfJWBGNAtudS+/PPYJqLIYyVWPguq1NSBv1w7kHfSwT8HBV6vjSfbJs+nHd1U1pRgL7t9MCwy8/F+7snaD3wPpO6JOXKqRVT5jManT39mudNuUNXryHHpA8mIiJs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4577.namprd10.prod.outlook.com (2603:10b6:303:97::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 20:00:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 20:00:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Thread-Topic: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Thread-Index: AQHYNz9tXzp0vUT6Z02tg1tG8znMeKy/CFqAgACT9wCADEQzgA==
Date:   Tue, 22 Mar 2022 20:00:41 +0000
Message-ID: <9A76C91C-6C55-4090-A931-2E5C9D90FBEC@oracle.com>
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
x-ms-office365-filtering-correlation-id: 6ebbc2aa-eba0-4cf5-b08f-08da0c3ea4e2
x-ms-traffictypediagnostic: CO1PR10MB4577:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4577CB452EC4AD8CD77BE77093179@CO1PR10MB4577.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7m0qqgdXSe1eFSWO6UxD5pCiiodx3rS4B1NC3w03tJhE9QZZ9QI/WNPmudT9RB2ga6ZkX3fCCRUmFWK8A0vO34Q/x/3zc4BvCOXTgKKO1ENHhTGvkNIJ2qP32UCcREVHRVm7AeES2jzUmOWurxu0giu+fK9j//4ySOX8HU9ngGtsBcSS7iV54FJvrh1DlbQdQztB37yZM2FlmokXAVl8DDQE26P5IAXhGoon+XPDEI2xk4U37XJdfoUjovDl70WlRzFz7xeRarOGFC/pCfyuUgRy1DCPEpyIbnIDiTLLNoVP1NiYH33c3uG8ra+XSZE/LwsYnQCbZ1f9YdR9AzJ/X5YLzRAjMF87/cVu85hjA6Dzv9f1LOZjWqUtKw9VyLQgXNadBiSQtGF3kxWrl3a0TGrfdEUF9ke7ouZIfN6KhNy4DIC+/eKrd00YmootPwXjjrOjTk9fBwG5eVFlsvemCH0kol5QHIbzP6ooe/Mvwk7fIjq14bgoAOLRRXtJcTHjxKYE+ZBuuH28/xcsksBx72kRmPpq2oQLoAr9pwMk4R1vlXX8XU4Tj09rYoxgmg2ktOpQlTq9qm1V47NXV9xWvBuyfenQy4u++eV4Mc/pUtPX5Ic4RN8SQ2gHCdJglnR8aJ04nl4Vr+apgbp8pORUK11dUIon1xnz+yrnM+E9U/MSnFWGDZZpNWmTL7vyY3GMS7F9sJVa0c3pvYcaGFOcHhD4DhxPRSPuMe+ybD9p72/QyT4WvZszBNik7UY7v2Ep
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(86362001)(5660300002)(6506007)(6486002)(6512007)(508600001)(38100700002)(26005)(186003)(2616005)(53546011)(36756003)(76116006)(2906002)(66946007)(33656002)(91956017)(8936002)(316002)(6916009)(122000001)(38070700005)(54906003)(64756008)(66476007)(66446008)(8676002)(4326008)(83380400001)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GrMF8dDsvcL6BTtvJ/uo1xt2zWpKEbAQplKs4cHRuIm6PqJUsZ1EfsMclpla?=
 =?us-ascii?Q?cNn6+XBUBk3/JL9nFzZQaHxWZpOWfAWK+z9mzMlAsoJTF7nhmrMLgCSY7ZGe?=
 =?us-ascii?Q?YKfsj1sMybQ26trWu0piVX5Ba7ahD1MlrbjVhmGAFj5rhE2bIDpMB9QehcDj?=
 =?us-ascii?Q?HHUZj98aB7L5/mi6rU96q25SnmVxMVplHWwdGc9YGUvEVU7txi0LQDJFv6go?=
 =?us-ascii?Q?pfMTm7Rp9kMCCuRt2S4W8a9LtOmocDmNVFbps8k32k/C2oA0HjPheb5ojioX?=
 =?us-ascii?Q?VndzXOcu7+xGiMx06geCrCD+rt4R4b8b3gg9RwPqEYMI6Yh5fr5bL2VEbYCO?=
 =?us-ascii?Q?1Nd6G9GT45nGgufPYkMOYnFSHUd1KxCvEwHQ+f3InOarWbg/FR/moWwRLsHo?=
 =?us-ascii?Q?9GUsFl+A5PsX2oH4TX3/puJztwV7+z5peNsMa2uOKxZWBH9OkVwkcED8qfmc?=
 =?us-ascii?Q?7wh1WwErhGFd6JJOOlroGe9sWHSxbIkRol0YHkCja2OGi7cvKBU/YWqU6w5G?=
 =?us-ascii?Q?obA+R92V9tn/cgc1jNcKGyYlK21Ora/lt1X5pOKr54uXNKiglBtaznLpLVcZ?=
 =?us-ascii?Q?+vdflj128rvw2ASHFtz+3krgQb9tUizDOsYR2c2W+3qBnMYXKWfjki3YGeW2?=
 =?us-ascii?Q?s6cYCuBieF5tK7GViMJpryVtDe8jwOK0U9mCTWhX55dl/MCbA9GP64XHMQ8t?=
 =?us-ascii?Q?D81J+v+al6NlmazjKDY1i65QHrJndDaBQ/bbnnM+o84KyDNcKTAWto/rFJwN?=
 =?us-ascii?Q?Kq2hjCSZg5xsfgZLmlQyQVB2V7ZjwmwV3NxVUkilx/UHq7Y/UyeTxinDN23f?=
 =?us-ascii?Q?Oz2mdVQnvkGytZHOSYa+zIVRaqvxqe9nVRDKrzOFoL3kabt6IVRBt6gS43Zo?=
 =?us-ascii?Q?HPtr+hKf1fDV8kJEe4tOQC4Mr91+yg8F1hQ671MnQVN6G0dLB7RjO3QzpAr2?=
 =?us-ascii?Q?C1tof+yYI/oJpUx90QzUAZsyJ2gKzq8tJIx/K07h39otq1FYo/0VKhwa65w+?=
 =?us-ascii?Q?RTQ45QEGvdRpDOKvUrqJji7AVK5W1ti3mpznbKr67En1rFvWYUTIuZr03um7?=
 =?us-ascii?Q?CU+z2CqVn8YWs41vKQAl0E9A+jcM+3O36wOfgSlPrX72KORQitF/tXtpvlJf?=
 =?us-ascii?Q?r0cetTBjLrFhn4z5o0CG9j3LoGseywv56XehXVuihSTt1eCx9deKX6yNJW/9?=
 =?us-ascii?Q?sPc09fAWULoGhtTF6soYjwNcYrMHPygqwX+tLFung7h7sZEdAi8iqVYlXTyt?=
 =?us-ascii?Q?hIt7oyeva3QnSCWhjOcndM0Nyj+0N+NmGu8zqLqqw4lpNVeOXZNxx6HV8mRf?=
 =?us-ascii?Q?mjAhZZZubKCHHrA+CC/aWh9bkmEXdN2AXL5o3lJXbJzHi6SFCgVrXZptyTh/?=
 =?us-ascii?Q?ip85OPc1dPdanExulQFjYPw7ig2A4KOFAk4ocyo3X1Kk0gwsTkTJoCeaxWbS?=
 =?us-ascii?Q?uzWxOvqRBDIUbfpweNcfwRztttSOE2Wp+45pqbq+iPvHZHd82UNKGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6A5A95DDB6E334192B92D2F53927CA1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebbc2aa-eba0-4cf5-b08f-08da0c3ea4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 20:00:41.9234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qhmn0aL5A+RJv7fIzYq1bIzsi/TL7F536LF5yUhLezjRPNRBJRV1gLRgJZpiTBCsPJ9UU8xo3fDKNfiUfHl0VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4577
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220104
X-Proofpoint-GUID: QXG2wYhpgC8bhfLtA8QHUS4cV0FrYaJu
X-Proofpoint-ORIG-GUID: QXG2wYhpgC8bhfLtA8QHUS4cV0FrYaJu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 14, 2022, at 8:41 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 15 Mar 2022, Chuck Lever III wrote:
>> Hi Neil-
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

I didn't fully understand this comment before. I assume you are
referring to:

55b592933b7d ("NFSv4: Fix nfs4_init_uniform_client_string for net namespace=
s")

That will likely break reboot recovery if the container's nodename
changes over a reboot.

My (probably limited) understanding is that using the udev rule to
always add a uniquifier could have helped make it possible to remove
the hostname from the co_ownerid.

For the record, I take back this statement:

> I don't think we need to
> exclude the hostname from the nfs_client_id4 -- in fact some folks
> might prefer keeping the hostname in there as an eye-catcher. But
> it's simply that the hostname by itself does not provide enough
> uniqueness.


Since the nodename can change at inopportune times (like over a
reboot), including it in the co_ownerid string can sometimes be
problematic. But I don't have a better suggestion at this time.


> This conversation seems to be going around in circles and not getting
> anywhere.  As as I have no direct interest (the SUSE bugzilla has
> precisely 1 bug relating to NFS and non-unique hostnames, and the
> customer seemed to accept the requirement of unique hostnames) I am
> going to bow out.  I might post one more attempt at a documentation
> update ... or I might not.

I now agree that the Linux NFS community will need to work with
packagers and distributors, and that we will not arrive at a one-
size-fits-all tool by ourselves.

I'll try to pick up the documentation torch. Thanks for your
efforts so far.


--
Chuck Lever



