Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50838464A32
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 09:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbhLAI6T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Dec 2021 03:58:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26394 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242263AbhLAI6T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Dec 2021 03:58:19 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B18bx9G007291;
        Wed, 1 Dec 2021 08:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=tw/mvQTPRvbECof/qfY2wmVxR7q/a9K57I3J4nzsxdI=;
 b=a3yi0USSXeouB82SE5NYdnTqEiPk2wVnB5vDOsrIkKX8fDYCDnDYytWXv3S3g0sGBSFi
 tCp87IDWoIdXXTErDm4sMaIVJGJBRkXmrN67ETzDQRIuG8jHPCL4rIjZudu8lHFTVu5S
 nL1yinBMTOL6i58+6WPHwq4ujStbgizwB+TUuYSdWHYOyJ1/vdcacioMC1T0NmTMiC6L
 lrqPpK2su0pJV6YvPssL9SYtdRNl8raGbSXirxIvYBArtSynXOPWZbtmDoA6u3gvVbTo
 0e67ipKae3YYFnw6fv+wNnkmhBEjHNOjIIvoHGhi98P7aLuKklAmWHzAHMjO286cmsRi ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9ye6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 08:54:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B18FFcB069059;
        Wed, 1 Dec 2021 08:54:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3ckaqg6eqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 08:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JncOwb/biFhIi1Hb9XqcXgl8+pzT7fPRm+sVfJmIB0uePbzWcKqpsS7r6nGe8gNAwYcXLl4HD1UPzQTwEe/XKb5biqsFyVGrYuqwOKz2RaZV7jzoIdpdPtlhZmSq/FSq0J+fVeu9lrwaMeOImoAMuGTmXOx74h+wTrR5NoRadLJzeS1df1os/0sWJruQd32rP8tZMY7K98Afc+1r2qcjYmzqweiRQ8XRkAbJgkI5DHJj9hBRlKl36yH/ySHeQEMbAXU3j3CUDHkcDnRWQScWPb542S13/ScXaOD7U2mQf3iD4szlHtqYufp0ad/Rq+h6SZH3mWylr48rpcFH9dczrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw/mvQTPRvbECof/qfY2wmVxR7q/a9K57I3J4nzsxdI=;
 b=fTtUKeVhlYjVtMdhIDMcfV/SF9DSm9bt2tQoWxpPnZj5rz5MGzkfZ6ujHVTd8t353XZsJaPAuFqTfkNrklggykMh2iHP66JZcosegabgvuhGbJqqIWk+eix5UYrgYxytgdLyxkeGY9AOqHYzH6gB4qplQTGzAUlTAjdrfFm0AuGes6drw65n1FjiOxp5ibXdlNU9buelebfsuA/jFDftVPJsmnxeBaX3Bf0gV9MQR4clRIEkWB2rV2iUxBwh/TFtEVdP9t8c4vM9wwyNEIfvIXBaiYCFYyMQBkBCfjsK9Sy3DxE70RBcSQhrwUxdT6Pod+9HormUdsEYnKwYy2X0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw/mvQTPRvbECof/qfY2wmVxR7q/a9K57I3J4nzsxdI=;
 b=sHgjraawnzUUoGEz2nINA2r4XwqQ2oqTywKy0CqhrbZZQ7Dp2Zeact5K+URTxgGcpHIt7Paf0cZenBUoZ85IAdi/9C12R9w4XKspdFTE4YjTQM8VAFs9hxpdGvu62jH+1rNpALocPQZs8AC24NfX3nlnniXamT74xN0T/bt66fQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5411.namprd10.prod.outlook.com
 (2603:10b6:5:35e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 08:54:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 08:54:53 +0000
Date:   Wed, 1 Dec 2021 11:54:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dwysocha@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] nfs: Convert to new fscache volume/cookie API
Message-ID: <20211201085443.GA24725@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AS8PR05CA0016.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by AS8PR05CA0016.eurprd05.prod.outlook.com (2603:10a6:20b:311::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 08:54:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9f80df1-77f9-491d-9b1d-08d9b4a83da5
X-MS-TrafficTypeDiagnostic: CO6PR10MB5411:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5411773BF4133638B3B431B78E689@CO6PR10MB5411.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pm0POrE/J+cm9PjPz749qFaugAIuBn4pBwYJbkjQm+2fBPZECoZ0GQ243Lz31Gu3EOSMJVOIya6x/UQNM1TzeKpCaCRYb7LfdHTu5TNzTwv+oJWxbBeZxTz2O4clmEWd7kxeCSnxLcS7bo5lCMTqghH2CWCINGyxtKvNQiTb4XMqZ2GQGCYCWdLKaVntmiZlehKigbPLKsAvtgmB0CZ/v+tFy8SvL4OUXfD4z2S2Ji3brxsRubbuH6utcjALdiQh7HYzOsHLpAQuzX1MsD1I//hxzTlorm5Ue6yqUQNlSUVyw7vwtl/c18CCEPo7axYlVYDg7cPos1KrsULFGdi3Q6oe3TRbNDMkkiclU4QUfe3LKwfTUd9DJKEq8gn4qxy1guJNQUmbw8TefJ36FmNq058OO+WXDPw8L+FnYi47SXtJ5zpCMUWRL3fnCA39HY44/pW7bQkBCHhMGtMvobOvpbIAC6Uaa3Lj7VDuJwXxj53yxigenYf7JC8DnZNi30VEnFnbz3LhLmCeEBgX1+4z+s+3wpqJ+qlYdtZtdBQNkHha2s1jmKzxLF0DckFZG8M2wC5vkOGayI/bx0zSL0VvqVbxjpvpDLcyZuN6dxQGKMWEhyacUDBbLpAyZoZJxOxVvQ+Rl0hm9uIa3/f4oVDUgMbOxr04KZFM/Vj3BpjRRYoabDen9tngTKyXTIMjinIE31YbK50M+5MEfIxLBUFNgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(66946007)(6496006)(6916009)(66476007)(66556008)(52116002)(5660300002)(1076003)(4326008)(26005)(8936002)(6666004)(44832011)(9686003)(8676002)(83380400001)(186003)(9576002)(86362001)(2906002)(316002)(956004)(38100700002)(38350700002)(508600001)(33656002)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vfj6JxjS0khlKusDdC74TF3n7KFjJ0QCJCvLp3PGA6g/SyjdcypfI+we0Snk?=
 =?us-ascii?Q?9e0rQP8gnz5Hg17tCTLpa2TajTgwzaSPKYqZ4/E6RNM4lUqbtilSrikHznSO?=
 =?us-ascii?Q?8xWWk20pRlPTLFWFAQS0Fbp2XrAByf/txOtU9o9cy8gW9RDpOTvfL2GNUIF4?=
 =?us-ascii?Q?hbreF4c/l58IFAnWHyPCxpZPwV5TkuNgd82y18WySDepZp3yeh4QxU7fJaPw?=
 =?us-ascii?Q?wcmczr/ej9kRmG9rzWmPezeKe+jchZ02Udur8pFfvXRguMMei+Zqs+Yzp8hg?=
 =?us-ascii?Q?4Vo4hdDOLVdzhgCeFH/GzgbObqJEQspDwdPVMoBAKP/yc54Foa1k+aPkyIgp?=
 =?us-ascii?Q?B+rpWFBJP55koAtuUOObtLEKuQZDYuxo52a65TqqCUYNn/KZboIi35QR/UP9?=
 =?us-ascii?Q?A5YVRLS6GrTclJ+4JgApMqHZmlqKa3tyRlNgyRFAnqdrYNC/Pt+oDePVb+si?=
 =?us-ascii?Q?19PGRN0DYeA+0mWKZ4EEgKQ9/lTmGeAvmTiTTF5Hqe3IyUAjbve2Q1GjpT4E?=
 =?us-ascii?Q?zjGFHPTMuVkyxzvH5ndTLAb2xgBdJCz6vHIyATlfvTghu/jEQDAhAKThzqVj?=
 =?us-ascii?Q?4VtJ5M/PSSOYxGhDIrHFbC5xHuWAm+KkDTyeqTEXN9PDOPoqsMnaldzFtkam?=
 =?us-ascii?Q?i/onM+6w+zVZCS3DhMf+6r4/N+47i2ZHS1lR/7mplibGiw7/ywIn8wO65EAT?=
 =?us-ascii?Q?13qwn0547Hh3mLP2RpSF0EBsHrIdss5oi9P3nJe+kLPvm5Ln3UOBE7svok91?=
 =?us-ascii?Q?xJVJIejTX9rDMYELC72V5t7vafqd1s01XoJ1mdDMvQ5zyH9PtW/sE/5a301Y?=
 =?us-ascii?Q?t56K6C22n/eN1uKMrC9AiSTf6iePAMW7q1UmT//yMvnhkz7mmbWZ6lrFNOoo?=
 =?us-ascii?Q?9WWY+BXIy5kKrvbXS46s7ZDW1WgfkLUozMRAlTVJ2erOOpYRZBZhnug9MxKv?=
 =?us-ascii?Q?7WD6bYqvgHmPDVeWYQZPoFud4xXlhiEfbR71E5YTOuG6sFvY0YCJGnoheAo4?=
 =?us-ascii?Q?OlP9p5/7oxB5YS3Fw/Ycn8r0XaDmLQg/3VfCDYx7PjK9WgyfVJ2HczmHh5WS?=
 =?us-ascii?Q?aV0oxyJ/6s/YPTwIQmzaxmHHZ68FFMB3Lp0/VGHF32Age14Qi1tMAbDnrTwF?=
 =?us-ascii?Q?UV6J/IrQPmArwCnR65lrm6PLMHFcniBZU31jvX+HOhUiyi0iu5SKaU0vAHnR?=
 =?us-ascii?Q?0PoWyStc1q9QrQIu3/bUcOzmlYrXumqO9a+4/BXZXYjUL8kNfeKlwJPWqT86?=
 =?us-ascii?Q?Q8HHWZ7LpgnYeZHexs2CX2QT/bD4On4ywxi/JTiVS9nSVGW/od+MSDojcA1Z?=
 =?us-ascii?Q?QJX4OhVQwCj6Ps1g17dm7eSJtkOaChyMqYPh2ZM3usqWp42xeHj0xG23bTy3?=
 =?us-ascii?Q?MrWuzscmchKKkoSzi7tM100NcXu6YVi4NskYFhu2oAZeuMYNqovF4jwDezxV?=
 =?us-ascii?Q?+8iJjR7yVg65JVCHJvcRtK5TyGQ+EdQ1/zj9LlRDbeUhEoa0eJ/B1/rgIZfS?=
 =?us-ascii?Q?9NoWiH9hQUmEyonG7qY/o3pUav1Xxa2JVRP51ufPTfe8dfHVLmH/qlVBFmQq?=
 =?us-ascii?Q?6l/Zs9TcEnvFHN9MwO796E2Q7yHEdiYv1mz3f9+xjVD7gY5dbCJAsigjcM0k?=
 =?us-ascii?Q?0DASqVBbqF5U55YAnO4RyzgkdQRrnDm2LkeBvLibbrjA3VfHqU61+RLExNyU?=
 =?us-ascii?Q?YiDXcgul76zFhOOz4p5+kF68H8k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f80df1-77f9-491d-9b1d-08d9b4a83da5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:54:53.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iph211rbULS96Hq2WMTe6lFsju0FtIaFv73vULjOGC4kqw3FOr5SxIkhu6cPQd8U3SczaYFFHUyFGdNdjbMex6+IS9mdPK9hSqR3H6MvNdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5411
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010048
X-Proofpoint-GUID: ETtuQYj29uXEwkVcNOd0MO3Kt86IrK3B
X-Proofpoint-ORIG-GUID: ETtuQYj29uXEwkVcNOd0MO3Kt86IrK3B
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dave,

The patch 1234f5681081: "nfs: Convert to new fscache volume/cookie
API" from Nov 14, 2020, leads to the following Smatch static checker
warning:

	fs/nfs/fscache.c:32 nfs_append_int()
	warn: array off by one? 'key[(*_len)++]'

This is an unpublished check which assumes all > comparisons are wrong
until proven otherwise.

fs/nfs/fscache.c
    27 static bool nfs_append_int(char *key, int *_len, unsigned long long x)
    28 {
    29         if (*_len > NFS_MAX_KEY_LEN)
    30                 return false;
    31         if (x == 0)
--> 32                 key[(*_len)++] = ',';
    33         else
    34                 *_len += sprintf(key + *_len, ",%llx", x);
    35         return true;
    36 }

This function is very badly broken.  As the checker suggests, the >
should be >= to prevent an array overflow.  But it's actually off by
two because we have to leave space for the NUL terminator so the buffer
is full when "*_len == NFS_MAX_KEY_LEN - 1".  That means the check
should be:

	if (*_len >= NFS_MAX_KEY_LEN - 1)
		return false;

Except NFS_MAX_KEY_LEN is not the correct limit.  The buffer is larger
than that.

Unfortunately if we fixed the array overflow check then the sprintf()
will now corrupt memory...  There is a missing check after the sprintf()
so it does not tell you if we printed everything or not.  It just
returns true and the next caller detects the overflow.

I feel like append() functions are easier to use if we keep the start
pointer and and len value constant and just modify the *offset.

static bool nfs_append_int(char *key, int *off, int len, unsigned long long x)
{
	if (*off >= len - 1)
		return false;

	if (x == 0)
		key[(*off)++] = ',';
	else
		*off + snprintf(key + *off, len - *off, ",%llx", x);

	if (*off >= len)
		return false;
	return true;
}

[ snip ]

    86  void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int ulen)
    87  {
    88          struct nfs_server *nfss = NFS_SB(sb);
    89          unsigned int len = 3;
    90          char *key;
    91  
    92          if (uniq) {
    93                  nfss->fscache_uniq = kmemdup_nul(uniq, ulen, GFP_KERNEL);
    94                  if (!nfss->fscache_uniq)
    95                          return;
    96          }
    97  
    98          key = kmalloc(NFS_MAX_KEY_LEN + 24, GFP_KERNEL);
    99          if (!key)
   100                  return;
   101  
   102          memcpy(key, "nfs", 3);
   103          if (!nfs_fscache_get_client_key(nfss->nfs_client, key, &len) ||
   104              !nfs_append_int(key, &len, nfss->fsid.major) ||

So then we do:

	len = NFS_MAX_KEY_LEN + 24;

It's not totally clear to me where the 24 comes from or I would have
sent a patch instead of a bug report.

	memcpy(key, "nfs", 3);
	off = 3;

	if (!nfs_fscache_get_client_key(nfss->nfs_client, key, &off) ||
	    !nfs_append_int(key, &off, len, nfss->fsid.major) ||
	    !nfs_append_int(key, &off, len, nfss->fsid.minor) ||

   105              !nfs_append_int(key, &len, nfss->fsid.minor) ||
   106              !nfs_append_int(key, &len, sb->s_flags & NFS_SB_MASK) ||
   107              !nfs_append_int(key, &len, nfss->flags) ||
   108              !nfs_append_int(key, &len, nfss->rsize) ||
   109              !nfs_append_int(key, &len, nfss->wsize) ||
   110              !nfs_append_int(key, &len, nfss->acregmin) ||
   111              !nfs_append_int(key, &len, nfss->acregmax) ||
   112              !nfs_append_int(key, &len, nfss->acdirmin) ||
   113              !nfs_append_int(key, &len, nfss->acdirmax) ||
   114              !nfs_append_int(key, &len, nfss->client->cl_auth->au_flavor))
   115                  goto out;
   116  
   117          if (ulen > 0) {
   118                  if (ulen > NFS_MAX_KEY_LEN - len)

This check is also off.  It does not take into consideration the comma
or the NUL terminator.  We need a "+ 2".

			if (ulen + 2 > len - off) {

   119                          goto out;
   120                  key[len++] = ',';
   121                  memcpy(key + len, uniq, ulen);
   122                  len += ulen;
   123          }
   124          key[len] = 0;
   125  
   126          /* create a cache index for looking up filehandles */

regards,
dan carpenter
