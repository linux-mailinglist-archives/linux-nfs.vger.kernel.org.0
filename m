Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AECA433B85
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhJSQEK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 12:04:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28492 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhJSQEJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 12:04:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JFiMXl031161;
        Tue, 19 Oct 2021 16:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hnigwcIQXLKYQ08Z7ZbOAB6ZJimJwgZzYI41wJMlTfM=;
 b=LGQF6qA57dXigLbFVkVVkgzTYq0B3HLoKgVkvov5SHBf5PJlHGA4Kp9UCJOt6bs+rX0m
 4v23phFN9MquZl3JyNODgEvAWLgqjmGk/w6sOveBtV1zSjYnyC5PNiMQDuqBqU+1GFyL
 okaiG5qCLYIuuhBVZ9DJ0YWT6rqUPAAGihUHNKRtECoR2gscWCj0udQxlgCUarGvLOX4
 Idiv2fawkxRwdwzJvr88NVHTXt0DsWNpjI0hvLBPoPG0NXCs+AfeX9E8aazmwyFBBIEY
 DO9wZcvTojsT8z7y/7hKZ/yWXPI29AbgkIOHNSoWqAGej4mDLKDAPfxR80+YvgCzKB6G sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsruc3cnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 16:01:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19JFjWL4036794;
        Tue, 19 Oct 2021 16:01:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3bqkuxjdvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 16:01:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLxxxVREMno6vqq0IGErRCNGoGxr/uq+dOfpaU0Py5W+XQFsPvvHXXsePxQyMnSdqFWaZhjHk+rFMB+xM2xpDMenqZhh5siy6gD+1fc/fVm1yvR8AO9o0c8vM3rcYfxfRER2UAg4qJwz2Rf1OzA1p7PK1x9ffC3HWrHoShWmqUMX5zD/NjeF2NEknrgRtOIfhdYkYN6T99o2hXZ8uo7j57Bdu4AObterlFb3qfAHm1xBx9ktCw7BUg1fi4xHbX77PWDdswNkUdUWh0dBFQOKpTTG8zU6j0NKysIVaAJSS8N4JvoJclHJVPx23T5tqqyjccqpVoFFoe/kBC2JfNCMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnigwcIQXLKYQ08Z7ZbOAB6ZJimJwgZzYI41wJMlTfM=;
 b=jvaBkI0rC3Z4cM5H2466SzP03ABELlZZuMTdZOpqOXDkYUfvFvBoOPynxmG0Fbxk3F+p6mXA4KwcQEZsWeZP6wUQVavNp9oeUjgC2Y5JJpzu5fz4YBp4lao0npfqzhQTvmbPpt79pNT83WfGpFkHQangN+it/5LXuhHAcHAaveKH8drfyUL2DV4oA7Rn0zqaMmH+8wgImCcjHlVHOKuGHrD2KXx25sLIaw3vPCvHJaqLdX667CvLi5/QbjMP2ZkgReDCp4FFE5Kb1Xl7JpQd9rnhqt2KIQ9PHO34jGMGpH0xX3gaN1CgboFw0hq/uB/CaSvO2au8awCFc5eBlSULAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnigwcIQXLKYQ08Z7ZbOAB6ZJimJwgZzYI41wJMlTfM=;
 b=enmnrUJkwIkjBQc815hqjh5XXHL+7XnU85jM6uueEvPlrROM/zpv5rvnjzUl5IT9fO2LlbRPf3baJTWGATm7f314MiEzEgF6/0r7/l4QDsDr405Njt01u3qL6/PXuV+zocRB+TtsT4MSJrFQ3SOOk4j8w0n7p/pw4DMl8ZWaL8s=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2968.namprd10.prod.outlook.com (2603:10b6:a03:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 16:01:08 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 16:01:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/7] NFSv4.2 add tracepoint to COPY
Thread-Topic: [PATCH 3/7] NFSv4.2 add tracepoint to COPY
Thread-Index: AQHXxGwEbncX/JTLN0G2I/WdYzvASavac9kAgAAFjQCAAALPgA==
Date:   Tue, 19 Oct 2021 16:01:08 +0000
Message-ID: <274F6575-ACD9-4506-A778-69D5DB582E9B@oracle.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
 <20211018220314.85115-4-olga.kornievskaia@gmail.com>
 <7C2CC1B3-732D-43B4-82CE-932DF82DD14B@oracle.com>
 <CAN-5tyFYdod0ubGXgoJvM0wSJ+skYpmS+d8JEu942BXbfFcVDA@mail.gmail.com>
In-Reply-To: <CAN-5tyFYdod0ubGXgoJvM0wSJ+skYpmS+d8JEu942BXbfFcVDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f79c4e5b-fc38-42c8-83df-08d99319a9e3
x-ms-traffictypediagnostic: BYAPR10MB2968:
x-microsoft-antispam-prvs: <BYAPR10MB2968CA729F3D6FDC80342F3C93BD9@BYAPR10MB2968.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wYXylUDQWuInZ4p+3wyMlGK3IvHt7tMoETfXWaZW4wliOK0E9eGNBFXoBR/NhiQ5QZAG7boJPvaDnqAGagA+guRRFAj4BGsryL9iBQfz8eeABUXy8v5ubNp1wiIIXWALrY26r7M6V/lBqT7RINLx/WUucNQATcjROlEDXyCvW8A89LR/eY+DJfYglO/Ry6c3Qm7BmbqRPblHAvg0XvenOtNBXE1bGXq/9WX7s5WfXo/IMOmvt/JLTuPgMLL1aMhqbQ/fMmM6UXjfJSd30U45MDTtZYvZmv4rhlTQoJSclVXbhYrhNXJquNIEF+22M+AN7rgYsW0XudEMRGLFQBnSnNWQjLnF3mvn5XPaW9OnjB8v+RMDrvPtm1F5pN9aR4WklNr6MIEYU2LTMlfHCCXupoxnvl3SfesgWFqmxZiKPQHWIltPyitcDnVfzSnCKzeZQHyCp90Czdt6xUxmg+n04EL4SiPk5ypM9cOu4Sjs264hmzsUWmXlJSdbOHg45sFNyi9YCsbOizd3FgFMJ4vhJ+IyVDGcafKI6ehw13wJsceuHWVhFnuQ1XIx3TqiRQ/ukf4SBVF3Sf4fAjq2d0FRvIMQZwXWeeCsqpJNxZQJFvWweeDvjw0d2DNaGE13UZnbjg/xBxJpcBgcU4PgyarXxhv7U1ZP/oV73WUQ87TFolW4wJecUzRv0rShwEA+/701Y6Sk2rEY7KES+HGyyphhYM3wdNQqXweQLLmVQKzkEPV7f4PIWAE5snn4gMtNYPQO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(122000001)(5660300002)(2906002)(38070700005)(186003)(38100700002)(76116006)(33656002)(8676002)(6486002)(26005)(6916009)(316002)(2616005)(66946007)(36756003)(6512007)(86362001)(66556008)(64756008)(6506007)(66476007)(71200400001)(66446008)(91956017)(54906003)(508600001)(8936002)(53546011)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t1RjICv9tj7k/enNx3OxbV0EoNLX1Gkj2tI0U8AGknxq6nxA9rZs0Bnm0fYH?=
 =?us-ascii?Q?fhtiDu83sCSy5opUfizXlIStyk2R3QgUkKQ8I9WL6RMBE6okyCdRWspEQGzz?=
 =?us-ascii?Q?zcGO3nnrNwKbWFor057enxWieWO7VRRCk/+EzjD4QZeN+OHNAtWo6cHw2wIF?=
 =?us-ascii?Q?/Au9Cibskv0pctC1e/VxKqmn3eAZHkNRVJUaQo0U4aNLWdq6CCs8/EhjevhX?=
 =?us-ascii?Q?9gmjTOOadmpNKFd6+i8klbLenHMyXgtMbF+BGrWNjgebKaS2pYgZuQ5bKD/X?=
 =?us-ascii?Q?UuEdPs/kDrV356s4HwxkucOJYAY5tIx8e0vfUieQanU3XDQGwo3/XgfylO2u?=
 =?us-ascii?Q?TEvBx03qCpEiRi7nPasBaFnNXQY4jOKxUnYB4hBWWK7+bX0Z5em18PhKEX2B?=
 =?us-ascii?Q?FO0tIjJlaAWF/mFavGxmzBw2ML6u+S4+3xVaYYbHmVaHEianpHz0atq+WLSX?=
 =?us-ascii?Q?N5DwQQBUotCECH98giUvge31PMzRnD16UNHUTD1GdREhipq+cTge61Iogyq8?=
 =?us-ascii?Q?Aa0j4hALWek8ZfN63Omb9XdF80ZBIeael6TXQtICFB3XU5pkLFG1VJ+rh+LV?=
 =?us-ascii?Q?K0JtmPl9CPUjghTDQDrGO73Z/Jx7dfIw6qqXJ3bdHqzUN8tUyK5L0d5xOrqh?=
 =?us-ascii?Q?6Q/eBFSYv5ZAt3O0who8qyV7fBAg7trnZ0cxw3Kn0Vo118HPQO1keFM9f3zq?=
 =?us-ascii?Q?n/36tPsyuaS4f+p/xJmd3bFd65q4xeOXrU0M1pRFEQ7WICR2X7fJqrNDXD1B?=
 =?us-ascii?Q?Q+5jtUzco6fbuiCjcPXF+SZM7IbZrvV1Y0k9Aky4oH2NTc/tThVSHDPe6nBA?=
 =?us-ascii?Q?BgdpcPNrc1Z5/AlhBgNVV15HvKQp//Wngk65Kee1BEYE6xi/PEw3wTC+9yR5?=
 =?us-ascii?Q?ybUHJHNV1QBsQZorrW39zs/BvCntnQ24JkaoqcM2HXMBMqf4CoPlEVd77h4o?=
 =?us-ascii?Q?Ok2E4dCgtwLU7Rrt/DlCQ5rOlJ9ynvvGIO6UPJtZv+nFi/ght/73N+/xNUEU?=
 =?us-ascii?Q?1A0liM8iAUOObF4skyZLuvfQ0h6qKrBgrXatY3s6xfVmBFtloiTQiiQfzFbn?=
 =?us-ascii?Q?DP2Av+5S04m7Ips2yWEVLMDSffQ7/bkiqdthOo3sKErGZ9GxCcVPVZOFqJgx?=
 =?us-ascii?Q?fMP2K/TRoLAh7Uc9uEvQ3+r6pqQvPWqKvs+h71bOB7N2GNl0SPBJQWu90Bl9?=
 =?us-ascii?Q?/wqv85ARaolAermewTIHCrW1OLUm+9hLmU0qhMFg0ey39FmG6r8y9LeGKyHB?=
 =?us-ascii?Q?kawufOyn3kVq0od5WhEQFdL3pdJrM8eWGU5nIPr+kMYVD/b96XtJdCwjYB11?=
 =?us-ascii?Q?fqLfPXm813MGR6hP25KAWp24?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D39AD13FF1F8594697DBFE895E5549BA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79c4e5b-fc38-42c8-83df-08d99319a9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 16:01:08.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmuQVSm+CLPjFinAiuubBP8f9qYUoCBtnnQHUNvIekOwZDyQwtw450mtfAgQ/uzelzJor81B8LJr4vr59K4XEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2968
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190094
X-Proofpoint-ORIG-GUID: IwoNg9HTKmxgLyNt7xdtUTRWl_VItKjv
X-Proofpoint-GUID: IwoNg9HTKmxgLyNt7xdtUTRWl_VItKjv
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 19, 2021, at 11:51 AM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> On Tue, Oct 19, 2021 at 11:31 AM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>=20
>>=20
>>=20
>>> On Oct 18, 2021, at 6:03 PM, Olga Kornievskaia <olga.kornievskaia@gmail=
.com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> Add a tracepoint to the COPY operation.
>>>=20
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>> fs/nfs/nfs42proc.c |   1 +
>>> fs/nfs/nfs4trace.h | 101 +++++++++++++++++++++++++++++++++++++++++++++
>>> 2 files changed, 102 insertions(+)
>>>=20
>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>> index c36824888601..a072cdaf7bdc 100644
>>> --- a/fs/nfs/nfs42proc.c
>>> +++ b/fs/nfs/nfs42proc.c
>>> @@ -367,6 +367,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>>>=20
>>>      status =3D nfs4_call_sync(dst_server->client, dst_server, &msg,
>>>                              &args->seq_args, &res->seq_res, 0);
>>> +     trace_nfs4_copy(src_inode, dst_inode, args, res, nss, status);
>>=20
>> There seems to be a lot of logic in _nfs42_proc_copy() that
>> happens after this tracepoint. Are you sure this is the
>> best placement, or do you want to capture failures that
>> might happen in the subsequent logic?
>=20
> I do believe this is the right place for the COPY tracepoint. There
> are 3 more logical decisions after that. (1) dealing with synchronous
> copy with an incorrect verifier -- perhaps that warrants a separate
> tracepoints as a generic COPY doesn't capture verifier information at
> all, (2) deals with completion of async copy but for that we have a
> tracepoint in the callback, and (3) handling commit after copy but
> that has a commit tracepoint in the COMMIT operation.
>=20
>>>      if (status =3D=3D -ENOTSUPP)
>>>              dst_server->caps &=3D ~NFS_CAP_COPY;
>>>      if (status)
>>> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
>>> index ba338ee4a82b..4beb59d78ff3 100644
>>> --- a/fs/nfs/nfs4trace.h
>>> +++ b/fs/nfs/nfs4trace.h
>>> @@ -2540,6 +2540,107 @@ DECLARE_EVENT_CLASS(nfs4_sparse_event,
>>> DEFINE_NFS4_SPARSE_EVENT(nfs4_fallocate);
>>> DEFINE_NFS4_SPARSE_EVENT(nfs4_deallocate);
>>>=20
>>> +TRACE_EVENT(nfs4_copy,
>>> +             TP_PROTO(
>>> +                     const struct inode *src_inode,
>>> +                     const struct inode *dst_inode,
>>> +                     const struct nfs42_copy_args *args,
>>> +                     const struct nfs42_copy_res *res,
>>> +                     const struct nl4_server *nss,
>>> +                     int error
>>> +             ),
>>> +
>>> +             TP_ARGS(src_inode, dst_inode, args, res, nss, error),
>>> +
>>> +             TP_STRUCT__entry(
>>> +                     __field(unsigned long, error)
>>> +                     __field(u32, src_fhandle)
>>> +                     __field(u32, src_fileid)
>>> +                     __field(u32, dst_fhandle)
>>> +                     __field(u32, dst_fileid)
>>> +                     __field(dev_t, src_dev)
>>> +                     __field(dev_t, dst_dev)
>>> +                     __field(int, src_stateid_seq)
>>> +                     __field(u32, src_stateid_hash)
>>> +                     __field(int, dst_stateid_seq)
>>> +                     __field(u32, dst_stateid_hash)
>>> +                     __field(loff_t, src_offset)
>>> +                     __field(loff_t, dst_offset)
>>> +                     __field(bool, sync)
>>> +                     __field(loff_t, len)
>>> +                     __field(int, res_stateid_seq)
>>> +                     __field(u32, res_stateid_hash)
>>> +                     __field(loff_t, res_count)
>>> +                     __field(bool, res_sync)
>>> +                     __field(bool, res_cons)
>>> +                     __field(bool, intra)
>>> +             ),
>>> +
>>> +             TP_fast_assign(
>>> +                     const struct nfs_inode *src_nfsi =3D NFS_I(src_in=
ode);
>>> +                     const struct nfs_inode *dst_nfsi =3D NFS_I(dst_in=
ode);
>>> +
>>> +                     __entry->src_fileid =3D src_nfsi->fileid;
>>> +                     __entry->src_dev =3D src_inode->i_sb->s_dev;
>>> +                     __entry->src_fhandle =3D nfs_fhandle_hash(args->s=
rc_fh);
>>> +                     __entry->src_offset =3D args->src_pos;
>>> +                     __entry->dst_fileid =3D dst_nfsi->fileid;
>>> +                     __entry->dst_dev =3D dst_inode->i_sb->s_dev;
>>> +                     __entry->dst_fhandle =3D nfs_fhandle_hash(args->d=
st_fh);
>>> +                     __entry->dst_offset =3D args->dst_pos;
>>> +                     __entry->len =3D args->count;
>>> +                     __entry->sync =3D args->sync;
>>> +                     __entry->error =3D error < 0 ? -error : 0;
>>> +                     __entry->src_stateid_seq =3D
>>> +                             be32_to_cpu(args->src_stateid.seqid);
>>> +                     __entry->src_stateid_hash =3D
>>> +                             nfs_stateid_hash(&args->src_stateid);
>>> +                     __entry->dst_stateid_seq =3D
>>> +                             be32_to_cpu(args->dst_stateid.seqid);
>>> +                     __entry->dst_stateid_hash =3D
>>> +                             nfs_stateid_hash(&args->dst_stateid);
>>> +                     __entry->res_stateid_seq =3D error < 0 ? 0 :
>>> +                             be32_to_cpu(res->write_res.stateid.seqid)=
;
>>> +                     __entry->res_stateid_hash =3D error < 0 ? 0 :
>>> +                             nfs_stateid_hash(&res->write_res.stateid)=
;
>>> +                     __entry->res_count =3D error < 0 ? 0 :
>>> +                             res->write_res.count;
>>> +                     __entry->res_sync =3D error < 0 ? 0 :
>>> +                             res->synchronous;
>>> +                     __entry->res_cons =3D error < 0 ? 0 :
>>> +                             res->consecutive;
>>> +                     __entry->intra =3D nss ? 0 : 1;
>>> +             ),
>>=20
>> I have some general comments about the ternaries here
>> and in some of the other patches.
>>=20
>> At the very least you should instead have a single check:
>>=20
>>        if (error) {
>>                /* record all the error values */
>>        } else {
>>                /* record zeroes */
>>        }
>>=20
>> Although, I recommend a different approach entirely,
>> and that is to to have /two/ trace points: one for
>> the success case and one for the error case. That
>> way the error case can be enabled persistently, as
>> appropriate, and the success case can be used for
>> general debugging, which ought to be rare once the
>> code is working well and we have good error reporting
>> in user space.
>=20
> I think I see what you are saying with having something like (in
> nfs42proc.c in copy)
> nfs4_call_sync()
> if (status)
>  trace_nfs4_copy_err()
> else
>  trace_nfs4_copy()
>=20
> That would replace my checking for error and setting the field. I can
> do that. But I'm not sure how to handle sharing of "call" arguments
> that we'd want to display for both the error case tracepoint and
> non-error case. If I'm missing an approach on how to can you please
> share, or otherwise, in my revision I'd re-write using if (error)
> approach and keep just a single tracepoint.

A single error tracepoint is fine with me.

If you're curious about multiple tracepoints that record
and display the same information, one example is in the
fs/nfsd/trace.h file, starting with the
NFSD_TRACE_PROC_ARG_FIELDS macro. It's kinda ugly.


>> In some instances (maybe not here in copy), the
>> success tracepoint is completely unnecessary for
>> everyday operation and can be omitted.
>>=20
>> What's your thought about that?
>>=20
>>=20
>>> +
>>> +             TP_printk(
>>> +                     "error=3D%ld (%s) intra=3D%d src_fileid=3D%02x:%0=
2x:%llu "
>>> +                     "src_fhandle=3D0x%08x dst_fileid=3D%02x:%02x:%llu=
 "
>>> +                     "dst_fhandle=3D0x%08x src_stateid=3D%d:0x%08x "
>>> +                     "dst_stateid=3D%d:0x%08x src_offset=3D%llu dst_of=
fset=3D%llu "
>>> +                     "len=3D%llu sync=3D%d cb_stateid=3D%d:0x%08x res_=
sync=3D%d "
>>> +                     "res_cons=3D%d res_count=3D%llu",
>>> +                     -__entry->error,
>>> +                     show_nfsv4_errors(__entry->error),
>>> +                     __entry->intra,
>>> +                     MAJOR(__entry->src_dev), MINOR(__entry->src_dev),
>>> +                     (unsigned long long)__entry->src_fileid,
>>> +                     __entry->src_fhandle,
>>> +                     MAJOR(__entry->dst_dev), MINOR(__entry->dst_dev),
>>> +                     (unsigned long long)__entry->dst_fileid,
>>> +                     __entry->dst_fhandle,
>>> +                     __entry->src_stateid_seq, __entry->src_stateid_ha=
sh,
>>> +                     __entry->dst_stateid_seq, __entry->dst_stateid_ha=
sh,
>>> +                     __entry->src_offset,
>>> +                     __entry->dst_offset,
>>> +                     __entry->len,
>>> +                     __entry->sync,
>>> +                     __entry->res_stateid_seq, __entry->res_stateid_ha=
sh,
>>> +                     __entry->res_sync,
>>> +                     __entry->res_cons,
>>> +                     __entry->res_count
>>> +             )
>>> +);
>>> +
>>> #endif /* CONFIG_NFS_V4_1 */
>>>=20
>>> #endif /* _TRACE_NFS4_H */
>>> --
>>> 2.27.0
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



