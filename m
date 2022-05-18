Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E0B52BE82
	for <lists+linux-nfs@lfdr.de>; Wed, 18 May 2022 17:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiEROrG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 May 2022 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiEROrB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 May 2022 10:47:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C965402
        for <linux-nfs@vger.kernel.org>; Wed, 18 May 2022 07:47:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IEYPZp011869;
        Wed, 18 May 2022 14:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0LPgbnTils31XzsCre7dn6432B0+BpLJDWpt2LDilQA=;
 b=ep9xlJaHvnFuem3G8ToZsmmOj3pfi0OdQYUvYUVQuo22dPX/mqgtuYKYU9YdPXtwugCK
 Q52o0psqzoi5MAy2hzAR/aqBx7eBvRTvm+Hru6XTj/Jul9YRYuaR3oimagqKSQd2aKfx
 +hM2sQaDpefuXoFpJx7wTLDjoZ9o+g58llGzkTjKbdxJG9pRP6KA+n00Ok17/4rqa1lv
 7Q8FjDzn0/IRLpbD2qgC1jpWBNmSVbtciMwxWx9v5PuMqrKorTlIiqjf1/gO1lboGAlN
 6sHJ6jpsmat7t2SccmtSY7yH/Y840wiHZJz1p4599K3GPdaFZS7JwrGT+YN9YW6vWfGn 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310sjke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 14:46:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24IEkl6H012071;
        Wed, 18 May 2022 14:46:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v9vcnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 14:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvmR3jRjCVt6cOZ7kMQ7r57lI/5C1dpJYA3mmu1zxFbWiQrxU4YHlr1opY23Hit6wC847s22kaRrQ3/r948ZqSOfwHpuoi6R7E1JNZFaeH5wqXeZlyzA7096eXUh53cWdbuuQ585wWf7YDPBlbXQPVLDb3XmP3Ff/foath2TW12h7gLrbaA/BpO+/I6SasCqzxn3WEDTvKAAssblJ8JW7z/Uaoo5hwYuxWFvURq8JQxlDPKEvgEodxRN+1lS2tVQT3BOP48FRCfDm3UkdaR31JImADdZtm7TK+f08on4abLVaf9JqBSRhGOpHc3KI2rAH1lwgJk1snDIHKutgccJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LPgbnTils31XzsCre7dn6432B0+BpLJDWpt2LDilQA=;
 b=S6aL3B+7FEMViUewgHts2DJpsNAcEB33pfY85ZeQlMd/WupKC/4h33NxXL4KhpOVjUOewrObxtUCMZephGK8ZUJnDZ823pdO+7rCW01qsmuqrJQi6w/5MWCT4+occ4a4U7rjGwmDN0is1WBbqELZ+FYdRA9dMk8kujJZWtBYAu48ooBIRmwK8cIaQVtDIZ6vu+WX7WaXM/i5JHMUHrTpcwlHEYcJ0TMBMIiURFKQ4QLnylnDYn+7Aw0oHY4Cv84HJ+Rp5ihdr+UVfsR1I8c8hStK/JkdIHe5rjon4bgKkAcYe0fLM6bU0rF3793gqbZDuqTcf3Nt6H1VjCCahGJO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LPgbnTils31XzsCre7dn6432B0+BpLJDWpt2LDilQA=;
 b=jvE/IgENaxCQFNaUnh13rlr4gngicjFxEedWyEp++mKa2lBgtCNDQYekFd3HV5xmJBdzvh9JN4qFetVWqRrNcykdPR5OPmXuctdLbrrp04BJ22hVL/SlP3RMbUaC6/tbQ15KwOSHoOGaPuX+VbySMw0LRBONmpVlI5GD4N5cVtM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4362.namprd10.prod.outlook.com (2603:10b6:5:21a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 14:45:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 14:45:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: report client confirmation status in "info" file
Thread-Topic: [PATCH v2] nfsd: report client confirmation status in "info"
 file
Thread-Index: AQHXHRCg4I/NVojQCUuAkyEihGCrLa0nUdcA
Date:   Wed, 18 May 2022 14:45:59 +0000
Message-ID: <41FCC628-9C02-4A8D-9E82-292AAF489E9B@oracle.com>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <87v99neruh.fsf@notabene.neil.brown.name>
 <87h7l6epmb.fsf@notabene.neil.brown.name>
In-Reply-To: <87h7l6epmb.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 931c4e5a-03f8-4e8e-ef26-08da38dd1fc2
x-ms-traffictypediagnostic: DM6PR10MB4362:EE_
x-microsoft-antispam-prvs: <DM6PR10MB43626BCF361AFC2817C369E393D19@DM6PR10MB4362.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2h+tQlH2/CwRWlIVHoCFHXDFjUAKVbAW6qDtbKb1H8dUf/HW1fy0nIUr7K5Jp6Aq2BA7ptP0GREPHTUbkDNRM4MtBth4AkbjcLX6ciajivHOu2/Y7uPN/0DQJKwpbHtvibf8Jrci4iz4R0SuGGGSSf0tbIso51sa+he39jjAKcrQzOPVBrUrgUk4rSwIKp4gswpCHNEX4kXNskFWovD4FPfzDZWu/kgSzpr/2S/7cHTG79BYrvvh6ts1yb3VVCAfzwVQfvRMY5aL24EnuL4VW8TYkYofqE120e7SQ+NeCDp/vD8IAjQWtKkBEKQYFO4enjk3Y4o/H4RPL5Hvbxnnkw59NAv1EozVldvAJdcy4nbl8mcZN7L9BNynB8BccSPq/VIweLDY9QZTpqOR7AXqHaAwqx1hP6dwSmPLLedEhSAboYOxrXTqHHkTrdYt9DyuKLdZMzO2TcTABl5KIp+mhNbvXbGIcDeXXPUWqNcXb3NWzIKHyKF2Qfwl0zsQWc+eeIOR4GhR26XqZlUS1gJ7oT0AHQ1p+aurVsKJxyZq7Wycpf6Z7aTH+vk12GWIE4+ohVzryS5di7er8sJzRhRcFhMb9JQEjyflbVSuj08vfy1ig9N/EaVrVnBRc//GDsa7xoAhcx7N8/8NWVyt23P4mhD1KLttM/BMJ5p60E0cuwe1YzniXyZ3qBGhBttVuOTLi5rGu+BhFGBpqptUZET2hzEQUoYkzS4qQeJ4O3n3bNJDT/XXgXgYnAvhIJA1an/xBh+y8aZNAMxqdPeFy0wVRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(186003)(6512007)(38070700005)(122000001)(38100700002)(26005)(2616005)(6506007)(53546011)(4326008)(91956017)(71200400001)(64756008)(76116006)(66446008)(66556008)(66946007)(66476007)(54906003)(6916009)(83380400001)(86362001)(316002)(5660300002)(8936002)(8676002)(36756003)(508600001)(6486002)(33656002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/ZkWkS21LCZAflEWovav2qx5nsXbwQU5Tlu/IG/zSC7HP4kAm6gW3p1Do7Xt?=
 =?us-ascii?Q?FjAImidL1Ripxxbx3u3OcToZNv+Q3lAj5eQ5xLSs7hLjqu1oHv8OurOYlZg9?=
 =?us-ascii?Q?Jr9as2wGAsg6nZ2g2zFfIa3NWX0pVXfPTqhYZ/qhWx5l3oF3/fi+M43RK9jB?=
 =?us-ascii?Q?dzK2vfn9WP+kiWBh9sr9Uc+iyaiFyjKysQWp9yQJbJHeOKqrzvcg+llWLAZj?=
 =?us-ascii?Q?C0/hbpGO4EDwsyupMVb3Bbs2wQ9YBlin7aoXSbGJy9nL6K1Gnw2RixsklIIl?=
 =?us-ascii?Q?sx0S/aoe+hGdsxWKZMir4UCV3vfp4ur2eObZNyJPP8ivg1cN3KVd2jnPicwp?=
 =?us-ascii?Q?Jw1psAU4yVd7e/B4b7QatQCq5Q8lWJe01uNgt9UJZFVA+3D58NDOFU2pAY/5?=
 =?us-ascii?Q?wMsElKiSx+CyTsl2pi3oxfwi+AiMFaPFDF3twy6t67Q1TXKMi+aIRPmFc8Bp?=
 =?us-ascii?Q?3HXOUCoeE7Ga5kMF3vCpj8K1Rru75TbpBF3Z+CDeNxoMre1ffW1LKCThGVr8?=
 =?us-ascii?Q?HNuTF85kpBR/71i1Fyuf5PjEH0uFdgufX4yHIzM5xRABQAq9K3WeaJW/nt4u?=
 =?us-ascii?Q?ByznYXRRpQ7/nJbiXf1qNlk9vcsRNOCUzUrP9YSChTffzUSg6x83IqiBVF9U?=
 =?us-ascii?Q?nH32ccu72PvhtlHp0DP7IfTE7E5zuFZwu7oBFugyzgrXxFwFi77VkJRZb2pk?=
 =?us-ascii?Q?Av/XgBaRl2f0JdZorhBngr4dRSUWq6cDcNraddZ1KhhC2I5v843c+JfGLDAv?=
 =?us-ascii?Q?95aDj1cQB8IYmqstmk6g9NMZ8XDvdsqpHVD7+nEvREmsyOwcsTg6DgOlDZko?=
 =?us-ascii?Q?hDuuQIEw6kevruSQm2vz7khQ7n/P0rCfF3sS0cew+lU+6/8hGc1Dcs2F1F2G?=
 =?us-ascii?Q?SqDWFvKhiSkrSgHbDKBI3aqj2KlOtBHA0SuXzNquYN+7IyWuwQRLmasEfgVe?=
 =?us-ascii?Q?zMVr6LBia1uoWyBiydFrvBsu/ujTmRBBGN74WWv1CPHAP3UMv2YKKNJ9FFFq?=
 =?us-ascii?Q?bJ3kM0wlhA03okqWY7op4s/3caRclxrx4RlAICwI5aMw6vHpxet+fQuenlk2?=
 =?us-ascii?Q?qGY5XrbeSDM9aarJXmBcb3fLXMT7LRcRJLcqN1l6XrQzS8LlQLTXNKtoBl5p?=
 =?us-ascii?Q?9a8J6MEbGijw3p2ek2IKvKxxgDxq3QNTY0Jb+buUUs+GsG/li3qZ/gmgT4FT?=
 =?us-ascii?Q?jN7wS6Q+RmxNiJwOeVTr6R9RybF3aQub65HE52gd6BhlPVPvPLSecbqaF1ta?=
 =?us-ascii?Q?7wzTe2yBT5QVPg3PFA+/E86DjPLM5gV0hYRbGAjU5WC42VRv/Fy7TKZHjOj0?=
 =?us-ascii?Q?MCcKETGRNq+gqtGhPKpDtlz8Zrnwa3921mdvuBAU1ZCrtUAJGEWm3a3+MWZp?=
 =?us-ascii?Q?gLO8Ty2Zd+rE5TvmE+xUvp+1MxgFhhnxCFdLFADMcNMCnQtbRSoY+2DYqMwP?=
 =?us-ascii?Q?QKQD3s3xJixryYWOlJwVfRey24/P04ojrXkO13Zzrc1D7R25VHlj3g0D1CS5?=
 =?us-ascii?Q?LbG641w5wXIWiSiQiNayN/OflUehiRCPw/QWmf/BNgYoMWEIBRseBhZ0HK5A?=
 =?us-ascii?Q?QciQ/Ra6+Bc5Y4svn6vL3QokineQxj7ZAOg5R7pcR6KlQwoogoXWfsruVTnD?=
 =?us-ascii?Q?XnRiRWRWbxrFdOaVJafYPfBYbi7+qL6fEMa2jPMDwISTiUAbb339bCf760uY?=
 =?us-ascii?Q?G+hvK0bkeO2I7kRRuRUSZVIvUqo+ALzJ1DsuVAvLM+Qf3tWl3HOzfIC0VOkB?=
 =?us-ascii?Q?gfM3+3nBL6i8D0yuOE25NDgYng1mPdQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6E2656F09E12E4CB8ED526D1EE8BA21@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931c4e5a-03f8-4e8e-ef26-08da38dd1fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 14:45:59.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ws4w2GmRnA7X2HsrBoajZ1nwknAeIEdQMroKDYFQTelMAyVplU1ZAKeiG+CfZOW+q0rJMexXOo2v0/xIWHLlQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4362
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_05:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180088
X-Proofpoint-ORIG-GUID: LF3-UMLOyvOVzxc9rK9EAFQAalXyyerU
X-Proofpoint-GUID: LF3-UMLOyvOVzxc9rK9EAFQAalXyyerU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-


> On Mar 19, 2021, at 6:38 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> mountd can now monitor clients appearing and disappearing in
> /proc/fs/nfsd/clients, and will log these events, in liu of the logging
> of mount/unmount events for NFSv3.
>=20
> Currently it cannot distinguish between unconfirmed clients (which might
> be transient and totally uninteresting) and confirmed clients.
>=20
> So add a "status: " line which reports either "confirmed" or
> "unconfirmed", and use fsnotify to report that the info file
> has been modified.
>=20
> This requires a bit of infrastructure to keep the dentry for the "info"
> file.  There is no need to take a counted reference as the dentry must
> remain around until the client is removed.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs4state.c | 19 +++++++++++++++----
> fs/nfsd/nfsctl.c    | 14 ++++++++------
> fs/nfsd/nfsd.h      |  4 +++-
> fs/nfsd/state.h     |  4 ++++
> 4 files changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 97447a64bad0..ec1b2dd8fd45 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -43,6 +43,7 @@
> #include <linux/sunrpc/addr.h>
> #include <linux/jhash.h>
> #include <linux/string_helpers.h>
> +#include <linux/fsnotify.h>
> #include "xdr4.h"
> #include "xdr4cb.h"
> #include "vfs.h"
> @@ -2352,6 +2353,10 @@ static int client_info_show(struct seq_file *m, vo=
id *v)
> 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
> 	seq_printf(m, "clientid: 0x%llx\n", clid);
> 	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr)=
;
> +	if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
> +		seq_puts(m, "status: confirmed\n");
> +	else
> +		seq_puts(m, "status: unconfirmed\n");
> 	seq_printf(m, "name: ");
> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> @@ -2702,6 +2707,7 @@ static struct nfs4_client *create_client(struct xdr=
_netobj name,
> 	int ret;
> 	struct net *net =3D SVC_NET(rqstp);
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct dentry *dentries[ARRAY_SIZE(client_files)];
>=20
> 	clp =3D alloc_client(name);
> 	if (clp =3D=3D NULL)
> @@ -2721,9 +2727,11 @@ static struct nfs4_client *create_client(struct xd=
r_netobj name,
> 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
> 	clp->cl_cb_session =3D NULL;
> 	clp->net =3D net;
> -	clp->cl_nfsd_dentry =3D nfsd_client_mkdir(nn, &clp->cl_nfsdfs,
> -			clp->cl_clientid.cl_id - nn->clientid_base,
> -			client_files);
> +	clp->cl_nfsd_dentry =3D nfsd_client_mkdir(
> +		nn, &clp->cl_nfsdfs,
> +		clp->cl_clientid.cl_id - nn->clientid_base,
> +		client_files, dentries);
> +	clp->cl_nfsd_info_dentry =3D dentries[0];
> 	if (!clp->cl_nfsd_dentry) {
> 		free_client(clp);
> 		return NULL;
> @@ -2798,7 +2806,10 @@ move_to_confirmed(struct nfs4_client *clp)
> 	list_move(&clp->cl_idhash, &nn->conf_id_hashtbl[idhashval]);
> 	rb_erase(&clp->cl_namenode, &nn->unconf_name_tree);
> 	add_clp_to_name_tree(clp, &nn->conf_name_tree);
> -	set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags);
> +	if (!test_and_set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags) &&
> +	    clp->cl_nfsd_dentry &&
> +	    clp->cl_nfsd_info_dentry)
> +		fsnotify_dentry(clp->cl_nfsd_info_dentry, FS_MODIFY);

I hit a "sleep while spin-locked" splat and bisected it to this
commit. fsnotify() can allocate memory with GFP_KERNEL, so it
can't be called while &nn->client_lock is held, unfortunately.


> 	renew_client_locked(clp);
> }
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index ef86ed23af82..94ce1eabd9d1 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1266,7 +1266,8 @@ static void nfsdfs_remove_files(struct dentry *root=
)
> /* XXX: cut'n'paste from simple_fill_super; figure out if we could share
>  * code instead. */
> static  int nfsdfs_create_files(struct dentry *root,
> -					const struct tree_descr *files)
> +				const struct tree_descr *files,
> +				struct dentry **fdentries)
> {
> 	struct inode *dir =3D d_inode(root);
> 	struct inode *inode;
> @@ -1275,8 +1276,6 @@ static  int nfsdfs_create_files(struct dentry *root=
,
>=20
> 	inode_lock(dir);
> 	for (i =3D 0; files->name && files->name[0]; i++, files++) {
> -		if (!files->name)
> -			continue;
> 		dentry =3D d_alloc_name(root, files->name);
> 		if (!dentry)
> 			goto out;
> @@ -1290,6 +1289,8 @@ static  int nfsdfs_create_files(struct dentry *root=
,
> 		inode->i_private =3D __get_nfsdfs_client(dir);
> 		d_add(dentry, inode);
> 		fsnotify_create(dir, dentry);
> +		if (fdentries)
> +			fdentries[i] =3D dentry;
> 	}
> 	inode_unlock(dir);
> 	return 0;
> @@ -1301,8 +1302,9 @@ static  int nfsdfs_create_files(struct dentry *root=
,
>=20
> /* on success, returns positive number unique to that client. */
> struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
> -		struct nfsdfs_client *ncl, u32 id,
> -		const struct tree_descr *files)
> +				 struct nfsdfs_client *ncl, u32 id,
> +				 const struct tree_descr *files,
> +				 struct dentry **fdentries)
> {
> 	struct dentry *dentry;
> 	char name[11];
> @@ -1313,7 +1315,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *n=
n,
> 	dentry =3D nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
> 	if (IS_ERR(dentry)) /* XXX: tossing errors? */
> 		return NULL;
> -	ret =3D nfsdfs_create_files(dentry, files);
> +	ret =3D nfsdfs_create_files(dentry, files, fdentries);
> 	if (ret) {
> 		nfsd_client_rmdir(dentry);
> 		return NULL;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8bdc37aa2c2e..9aee72f65330 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -107,7 +107,9 @@ struct nfsdfs_client {
>=20
> struct nfsdfs_client *get_nfsdfs_client(struct inode *);
> struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
> -		struct nfsdfs_client *ncl, u32 id, const struct tree_descr *);
> +				 struct nfsdfs_client *ncl, u32 id,
> +				 const struct tree_descr *,
> +				 struct dentry **fdentries);
> void nfsd_client_rmdir(struct dentry *dentry);
>=20
>=20
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 73deea353169..54cab651ac1d 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -371,6 +371,10 @@ struct nfs4_client {
>=20
> 	/* debugging info directory under nfsd/clients/ : */
> 	struct dentry		*cl_nfsd_dentry;
> +	/* 'info' file within that directory. Ref is not counted,
> +	 * but will remain valid iff cl_nfsd_dentry !=3D NULL
> +	 */
> +	struct dentry		*cl_nfsd_info_dentry;
>=20
> 	/* for nfs41 callbacks */
> 	/* We currently support a single back channel with a single slot */
> --=20
> 2.30.1
>=20

--
Chuck Lever



