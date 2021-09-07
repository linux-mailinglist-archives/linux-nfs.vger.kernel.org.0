Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52DC402B43
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344892AbhIGPBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Sep 2021 11:01:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12588 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231590AbhIGPBl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Sep 2021 11:01:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187Ejd3p026789;
        Tue, 7 Sep 2021 15:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BhN+qtdOAK12/SctJEpf+I82IMb1ZXkbtCOAvkHsOjA=;
 b=c8SxJnwhYD6cDFOCVwpXAVYdPvnY9R759rF2QFQR5veEDkWztg01K8laGfVrQCoDKld1
 d4IY3c0Kj9ziW1jwSWGgkVvPURtqjRCP8ZkOxD5YwiVWnK+2110uAu1ZvJeop6yBWrQF
 McS3bWGNc17McWeOK/Zq2zuyi5F0GaouzHeegQFPmqQ3UHmKnfzfaGl7xG4yAaZ0iMl7
 OkHlDLGUaPLwR/Pz5C6rH+FZhM/M/xk0Jbe1RaREvN+kDnoOVkcLTcy/7SbgDZ2MQ286
 KF1wshA0Gl1pFWdVCPmJjTbVOlhJOIJv1PV9hwll6PFQ1nRln7PpofYVxWuFugEZVwXq Kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BhN+qtdOAK12/SctJEpf+I82IMb1ZXkbtCOAvkHsOjA=;
 b=xS6ouF0UFSEDN27VkRc90fFpabhlW4/I0cf1WeIKvC426VbPRA5kFbdmbwV8B++DpGYn
 xxBM1d0hNVp26QwbulBp9LRnGsnkUPKK+usWO9Xg+cVKspeewghmCF91D+3qmibN+iT6
 t7gsKYlSwquWtuinBFRnS353Ri15FVnhFmahpUHK39C+Yk5CgDi0ZO39tmwaz5DKRG3t
 KOvMAvfEuEAIqdRERLEseTbkIXzdDTwfBfGAMNj33DNaiR08A3IEAd3SyufdcEz+8Hdd
 ffLlh6tdBG6e/sUf3PiDusM8/IWhGQFMwVp63eXn4UAevhEcviOmad7Ts6dl4xo9S8qb zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq29j81g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 15:00:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187Eu9t6037936;
        Tue, 7 Sep 2021 15:00:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 3auxudtb16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 15:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1zpX63gBzkTf0+xLUr61ryLHtHULdIorZ3EKGvvDNEg3YLjVEDsvDd4hof7thEC+Xz86puOZnB6vSnRUPw29ovjsPSK5q2qkUB/wfqDj0KmeoaIXAs2Th5wBG2tpFm5gxrUbPmMBrSyBj0TO8VOTFd2xee/cCWfxqyCHvJT+H0MBRE03UVqFt9/INQ1gUj65PSqR96XQHFBgh6EIWvqtp7Cgn0a5WeN199DPCycNUbbd4eg5+J/+ZochI0igBbrV2kGgu+HQpz/Qy1Hz8wgTqcuPGBrewgGvJ5dDPDmn3rIho9vJ+pbJAwpAxg2nrkzoia55EdV5bZW79N7/uss2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BhN+qtdOAK12/SctJEpf+I82IMb1ZXkbtCOAvkHsOjA=;
 b=ltihXvfi5lFTc67vLtb0zQN/Isljebs3Ros71SdWqYw+hkPQcd5vCflnhEusDjtO9t3mZVkET7DAB+voWRR8yiWkLtjnymzuqgSV1uOL7T2C+l5tKcYCc1N5NBHKyqut45k5SzNsUL6T2jg9KO88PvkBS82mVGS3vxql0sD0e3bZ/ZZJc4ojW+Kh4aLmNdxs4uxamgcj9kny2CnK+58uaeM6eTEoykMwGM8o6HR53QzVrGQ9Kjp6fwJ8Rnw0StV1lwrTlqfWj4EKq0iXcyUw0QxZXhi83NSJZOMQFqI6pE6jPQ1OdcL9kCEeIkDzubFY9T8u/E/brO2kdgqY0+adnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhN+qtdOAK12/SctJEpf+I82IMb1ZXkbtCOAvkHsOjA=;
 b=knImFO1pvxwk13RO1X2ond9LMGqEuQaY+vx3IMFZC7NvHdcmzpq9liK3k93VMwccohjvKaHHplfHDBLUDFPwtaL+WUF4WJ7tNmvXNzzlpckiSYLNFE0gcYo7h7cVLfHx8XkPGeFNkWiuRi33cFNOcKBkXx6BqDTYaxz4kdSbRuw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 15:00:23 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 15:00:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Topic: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Index: AQHXo790A7Wd0tfa/0e3moKXgUhSZquYZ4qAgABDIAA=
Date:   Tue, 7 Sep 2021 15:00:23 +0000
Message-ID: <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
References: <20210907080732.GA20341@kili>
 <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
In-Reply-To: <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd631b4e-ac6e-414e-6241-08d9721037f4
x-ms-traffictypediagnostic: SJ0PR10MB4623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB4623AB929F09F8871B66A50C93D39@SJ0PR10MB4623.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:356;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xico6EywBH0+LMEhB/IW6GiYR34QznRPtoQbAaQRDn6eyDW3tFsZIpf1u1K3IFjWhOsEOrYSpay0xyy+ndY/Jplr0NtQg2bP9gIbib/mwDx7fg02hU1JdsDbztIG7AwbCvTdigzVKZo9jDIVNOq6uaJEDPySnM8ZG7BlAf8xF/8YGIMb6fkfFX6Vtr1fhcysdYYTr2NbmxSc86vHhXSQWy20zs2EnUWADr/Vdgq4pmoorxw1G9h3S+tPTzh/xSPorYXkj8Qkw5L7MnMdYlDwZjwkz0OALMYUACSS38E93M9GpWCz4vEFf7p7onS2zSCKRCJldmjg2sfHCbwCUvfHhYumdo91izH22Kwokv4zIYrfy7xX9zQvEJ3VOz7FUFrPvdQVPZLo2Hlp4rV9hj8n69ToDXmYds2cq+wJOX9WND317dDVjLD4Q+yw3w04hlPSbowrn4la0CobJz6IuP32Nlbybba+sZolrVxvC5kTNZaKWwuNTX7a/ETOmKnCNgxeaoL0d2ISFFvoOHiLx/qR5KESk0jclvinto/WjjBH+M4KVJMkqW0ZYY1hPQNU8mlD7NjCcLjVDL9VQah2BB8jCyF8bXO/R4w3aKZqIqR+mbXCkfR1KdAvLipaJu2cfBBf/4j/qjIBq62w8yZpnrjPuL+5/7XFOWokrq/HBwfi+wJRVBLlUXUyLfmgUw3JrgnGz0ZNk4VNDJ+ZsQkr7DMGUOwNbskbIOd4rab/3E0LlDrUDq6wSBHf8cj9PddNKn4u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(4326008)(54906003)(64756008)(66446008)(122000001)(66556008)(66476007)(2906002)(91956017)(36756003)(38100700002)(316002)(6916009)(83380400001)(71200400001)(6512007)(8676002)(86362001)(33656002)(478600001)(5660300002)(186003)(6486002)(8936002)(26005)(38070700005)(76116006)(53546011)(6506007)(2616005)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rycg3InAt2cKA4Noy0+s8zPGOVCr70XHFUHiskzMdZXesTsZAe42/6GdRKwy?=
 =?us-ascii?Q?b6p78dzbQchDnfJVd7/N4lQHMy62LvR6B/dVSrwOgMh0URr3pkiiBzBxSAhW?=
 =?us-ascii?Q?qyYqRLCJ1eSXr5Bbhl44vyJjczT/lRFXFnz0Vf/jyKYOtSi6fnj0F0NLi15h?=
 =?us-ascii?Q?TH2/ku3gn7mWjjuraa/bD6RgDEgDfWENrKkEfM1keaTHV9tgsDNZ75ojnc0m?=
 =?us-ascii?Q?XuIarj4Rx1CSOJyM+WBz2kE1ZlXV5PutGUsc9cRXkt2yrdwR9/zYMFZeik58?=
 =?us-ascii?Q?STAQbmQEPCdbwPEAmyCCDGFm8Y5XvZKol68E8VWaCSr0kDpDU3/z67U1a9Kk?=
 =?us-ascii?Q?m5mq1Jk0ZEG0xxUlDcyRD6UgVFDqKZLuRW8pRWbbpOV+03gEunynpcEP6sCD?=
 =?us-ascii?Q?1iTyirXVUR8xuLPA0u7ceOaLMnJRxWXk7aQtjoswJmt0EO+jgLEna20kzLoy?=
 =?us-ascii?Q?YFdUmaRBlCb+IHLL0wq7D/uRbxvC+0oyQZUuiKMjHw2KSBFpriZncwBLdBNE?=
 =?us-ascii?Q?ecECDO10RgA4BjR+jN0ycDi/MtFzsg5juA58kEyvb8Wak+uXMQTATdRqVO1e?=
 =?us-ascii?Q?OMNyRr3VTxqL4+sEfwOYl9/FgueUAi/fic7P8NmpkRAE+T2AuxnvkqccKABq?=
 =?us-ascii?Q?MfyMfGbXLoVclu1BxeDnE1LyxzZ93kOSwiW0c9xAfyLvYfR3SxCdrAotH1Q1?=
 =?us-ascii?Q?QOAZS38sdDi3JVdePlUMAGHqa/KB21Hozxecxrs08VOCWn+OrQxucDT2w0Lx?=
 =?us-ascii?Q?IuwHl6KrhiQH+qlPudRPMQq0p/RwjmnZZ5Sm3VaNVcu2v81/ST0OFQKfBjlz?=
 =?us-ascii?Q?yrqr9hS6Wo4oK5AIT2dWuB/s+xLrjgYuFUY3oNTs1GC7qfEuryBiZxO+vOlB?=
 =?us-ascii?Q?RWBWeL2cMbPAszI1lGmq0+3WJtdZVZnZuQIs/I//5YMx65S+sOMtYAjPlUEX?=
 =?us-ascii?Q?rqLLDnN/9fhfBgTUtpQc0HguSMgBgJWoDcMnZHbksNbjIz+XUC2/ygWLs4uk?=
 =?us-ascii?Q?No0sw44Je7ahvWXseLe5Mga9gVd4NyYgEQ69k2U4nLXeW102RRvdH77prB6e?=
 =?us-ascii?Q?WJkf8VT4dtOoBvRCEMBgShYkRWEUbuU7D6VwywIYEhXmEsQFVyPtlvr8dca5?=
 =?us-ascii?Q?W0NyctjaRFICaLM0xNECjbyrLGBjxgeYWP8Z0sHWFTQ1Iy8h1v08KUQC8qOt?=
 =?us-ascii?Q?DaSqslJalSG312JLx9bXkTtB4o4rrzaiycS1sm2YJyKqOLrx/+KekAff+/bh?=
 =?us-ascii?Q?dibVjrJwh1WTdmnLrjWtFWMQDXs+DFtAoB4VbmBOpSoKbnwAkMQR0JO1yOrs?=
 =?us-ascii?Q?YJOG5fOItaaiztg3tYmGAUer?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1A3363C8128E34893D6CA382BB46E5A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd631b4e-ac6e-414e-6241-08d9721037f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 15:00:23.2356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5g/4Cbf7b8VCMv6P3DgoPzL41xbz8bPqHQJZ0VtgDaydOVNHUqeXoNLiNUqZoncob1g6IANXElktPuLyvu0gCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070098
X-Proofpoint-ORIG-GUID: 91HlHCZnlOFyXbbdzu4aSSSOXTXCQM2z
X-Proofpoint-GUID: 91HlHCZnlOFyXbbdzu4aSSSOXTXCQM2z
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 7, 2021, at 7:00 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2021-09-07 at 11:07 +0300, Dan Carpenter wrote:
>> Hello Jeff Layton,
>>=20
>> The patch d20c11d86d8f: "nfsd: Protect session creation and client
>> confirm using client_lock" from Jul 30, 2014, leads to the following
>> Smatch static checker warning:
>>=20
>> 	net/sunrpc/addr.c:178 rpc_parse_scope_id()
>> 	warn: sleeping in atomic context
>>=20
>> net/sunrpc/addr.c
>>    161 static int rpc_parse_scope_id(struct net *net, const char *buf,
>>    162                               const size_t buflen, const char *de=
lim,
>>    163                               struct sockaddr_in6 *sin6)
>>    164 {
>>    165         char *p;
>>    166         size_t len;
>>    167=20
>>    168         if ((buf + buflen) =3D=3D delim)
>>    169                 return 1;
>>    170=20
>>    171         if (*delim !=3D IPV6_SCOPE_DELIMITER)
>>    172                 return 0;
>>    173=20
>>    174         if (!(ipv6_addr_type(&sin6->sin6_addr) & IPV6_ADDR_LINKLO=
CAL))
>>    175                 return 0;
>>    176=20
>>    177         len =3D (buf + buflen) - delim - 1;
>> --> 178         p =3D kmemdup_nul(delim + 1, len, GFP_KERNEL);
>>    179         if (p) {
>>    180                 u32 scope_id =3D 0;
>>    181                 struct net_device *dev;
>>    182=20
>>    183                 dev =3D dev_get_by_name(net, p);
>>    184                 if (dev !=3D NULL) {
>>    185                         scope_id =3D dev->ifindex;
>>    186                         dev_put(dev);
>>    187                 } else {
>>    188                         if (kstrtou32(p, 10, &scope_id) !=3D 0) {
>>    189                                 kfree(p);
>>    190                                 return 0;
>>    191                         }
>>    192                 }
>>    193=20
>>    194                 kfree(p);
>>    195=20
>>    196                 sin6->sin6_scope_id =3D scope_id;
>>    197                 return 1;
>>    198         }
>>    199=20
>>    200         return 0;
>>    201 }
>>=20
>> The call tree is:
>>=20
>> nfsd4_setclientid() <- disables preempt
>> -> gen_callback()
>>   -> rpc_uaddr2sockaddr()
>>      -> rpc_pton()
>>         -> rpc_pton6()
>>            -> rpc_parse_scope_id()
>>=20
>> The commit added a spin_lock to nfsd4_setclientid().
>>=20
>> fs/nfsd/nfs4state.c
>>  4023                          trace_nfsd_clid_verf_mismatch(conf, rqstp=
,
>>  4024                                                        &clverifier=
);
>>  4025          } else
>>  4026                  trace_nfsd_clid_fresh(new);
>>  4027          new->cl_minorversion =3D 0;
>>  4028          gen_callback(new, setclid, rqstp);
>>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>=20
>>  4029          add_to_unconfirmed(new);
>>  4030          setclid->se_clientid.cl_boot =3D new->cl_clientid.cl_boot=
;
>>  4031          setclid->se_clientid.cl_id =3D new->cl_clientid.cl_id;
>>  4032          memcpy(setclid->se_confirm.data, new->cl_confirm.data, si=
zeof(setclid->se_confirm.data));
>>  4033          new =3D NULL;
>>  4034          status =3D nfs_ok;
>>  4035  out:
>>  4036          spin_unlock(&nn->client_lock);
>>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> This is the new lock.
>>=20
>>  4037          if (new)
>>  4038                  free_client(new);
>>  4039          if (unconf) {
>>  4040                  trace_nfsd_clid_expire_unconf(&unconf->cl_clienti=
d);
>>  4041                  expire_client(unconf);
>>  4042          }
>>  4043          return status;
>>=20
>> regards,
>> dan carpenter
>=20
> (cc'ing Bruce and Chuck)
>=20
> Wow that is an oldie, but it does seem to be a legit bug.
>=20
> Probably we should just make rpc_parse_scope_id use an on-stack buffer
> instead of calling kmemdup_nul there. Thoughts?

We have IPV6_SCOPE_ID_LEN as a maximum size of the scope ID,
and it's not a big value. As long as boundary checking is made
to be sufficient, then a stack residency for the device name
should be safe.


--
Chuck Lever



