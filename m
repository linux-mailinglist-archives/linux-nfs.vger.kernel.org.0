Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E2D589D8F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 16:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiHDOgM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiHDOgK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 10:36:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F022B2D
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 07:36:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274EX0mb011505;
        Thu, 4 Aug 2022 14:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=e/TUcQ9UC0U2TGn6MXCpmaOaS6iBMeS05UsXAO/8/PM=;
 b=BsJfY1bAYmpdDASycmnYkkfJF3WtzKXD0xU6OmaxSgVQlYVgU5iAl9naDIWk+oTRFtLR
 KaZfPVKOBwikaXFpiekGB07YcLz87D43E3Z5IpkR+p7ccO3yssGqKX1OYhmTPHzWPuWe
 tJAD2hWFiR/ldDohA5G0O1IaB3C8z5zwV0BnaDkQKGOZxXyV7IFBBHsLavhaOkL3tU8t
 UxGZsUyvZfWuT7R7M48U/Mnujue9YzDJDWHuiVynAc1GB52nfanbvt4LesAR/Y/Vrbeb
 0HYJEDjUhhBrr8k8YRrwkSV8Fv7fyfAKhGLUuygjenulfQxVsFsmm765rA924RjdBzwE og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8sd4bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 14:36:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 274Dh35D014282;
        Thu, 4 Aug 2022 14:36:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu34da9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 14:36:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F84JcdjkaKi+nOCwwYlBe7Woj6thqy+O679vgiePYnQSmNtUrU/Zj4rJFZOnP+h+QhwHgK00hEWwvTgMCZETnl2H+qM6rjjlpuNBs3BftBDoy/O2eKVnM0yk2D3LAWo88ou5o8J04GH4sScylSb5evqpTVi4v3nzXSyBYjBxzBgPOllPLeX4CLZgPF8XQwLDx3cjyHf9t79U9It6wiUBtGwwOWlkVIaXeuV/z6HHP/1JWOdgNEGYqWgFJzmUxURDjP4eAf9z17desSxhjsdccOWaeAqXJvjoEq+uNA8P+UMZtAKDAG9PyQ9O2MEkYSrhEkEx/7iCyoZS9+m/jfiHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/TUcQ9UC0U2TGn6MXCpmaOaS6iBMeS05UsXAO/8/PM=;
 b=ksiO16zFrdr8/R+NtRlG4eCdaETs5CMZVPCh16kyixL8xoRpk0axxQJhRuPHo5na3cruGs8zJHJTTGVRaande6g9VMxcl23QwPvRWvrbVc7e4CuEhGH++S75YJEiNSibsjpVPR5s1vjny2L4uajCgZaRHWhjfFemoMmVJpf3g2U+cmbR3HNIuH1uKWOeH6lCGBetRiXabtT1f5Oa4F2pDEJBJV/hPE3DGjiAiB0XNihbjOPa3v3yCxlS1ZRGTn3exY07ygFgwhr+NSq1n3T/x1xjVn+hxaqpa3UirL5BeVet8kcR+5GjUUsnWE1Dns/zewrTbx2WHGrp5AAjsTyAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/TUcQ9UC0U2TGn6MXCpmaOaS6iBMeS05UsXAO/8/PM=;
 b=lemE3DTOUXSPPT4Rt+mBGL6vVFf+swCDV7IyZb+cbk8EKCW6ASZ3rqbGb76cRg0cLgvKAiQ4/vbezh3Z9NOUnUm2DGnrwsZjy9XrsM/2Bn69s1trNMVbhUpgbNQHdiiAfWzlAR68l4NpEn4fjIuuSEbkbC5hZXI4/mXj5Q9E3p4=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BL3PR10MB5492.namprd10.prod.outlook.com (2603:10b6:208:33f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 14:35:59 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9d56:faf4:482e:e6f5]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9d56:faf4:482e:e6f5%9]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 14:35:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [linux-next:master 13556/14285] ERROR: modpost: "set_posix_acl"
 [fs/nfsd/nfsd.ko] undefined!
Thread-Topic: [linux-next:master 13556/14285] ERROR: modpost: "set_posix_acl"
 [fs/nfsd/nfsd.ko] undefined!
Thread-Index: AQHYpwYZplOXsZmh40K/PltncN/VKa2dL30AgACiBgCAAP92AA==
Date:   Thu, 4 Aug 2022 14:35:58 +0000
Message-ID: <43A04A4B-2EFF-4877-AFCE-DA51122CCF14@oracle.com>
References: <202208031404.a1NgfSzI-lkp@intel.com>
 <AED75B2A-D639-422C-A744-CD40E2490E92@oracle.com>
 <165956889874.12283.5007966519219519664@noble.neil.brown.name>
In-Reply-To: <165956889874.12283.5007966519219519664@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6f8ae89-43d9-4e29-08f9-08da7626a5d1
x-ms-traffictypediagnostic: BL3PR10MB5492:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9rRS7mVmHS4okup+nDT6oG2SBpaJaiAFwBJJQFjP5Z1fs+3NdwJ2EM1LWF3niutOsN3cQUYYK0Xlk5hwvY0iNqIbUUjN+w5B6P8P1e1RXPJgKS/mC38GuefpQBlPRjrf3aZ8FqfQ8V+0FYz3shl+InNTzefR8RqqOwIG4kqrENc+JUAuCwuwWTC6mJUt3muqks/m9kzdyN3Zob/5m5tkQM2TYyu3chW1TADHnFT4PkMAWTBWnZ/HAXkBDydR8dMfuSwNYik82C9yRO26wKGPJlElXdBEHjXCATVwmJDepwsjFMMkCEJal1b0WFX2jhJIHqDu/+tNT18KIpmBR2UBvd6X/58C2QQdQtXwudFMT2SyX7Qc5v9W5CuWZpjQbq8AEAxzTQBVH9+YZGgaKbU7XnmzVsphMvck4AGvHS3JEpag7Mkd08IjMB+c+8R/8dpwde2+VArOiRswBEHkqm7PqGwds1/pPEPn94yudQvqGchu3p3nilLHgFi6nIXcq+inEVyAtgEzm2vP0egxAmVX3fAPS+hC8G754PqU1WpaneX25xUjiL2xEfm5ozkEbjVe82jVMiX9+mPbTYEfMbtQ1Sc5B6Mk5UAshY016Qy0SXQbP8Wxp3Jrt3QWdaMx+PAFlYoBXeW7HIBXhG+Gxd/PT8LI+VCf6b/iaePP8UpqP2JWVZ4Mg4IXCBbUJqLjuo/vh33HpupdGAiqh+4yAn7Ch7oo1oTLRsEuPDwjbXomcmTyvjxp8L0WiWoACXztKBFFAWa33/IvmHw3B9wnuJk9KfbbjUpETQAfV0mvaf8YbIW8ms/6HD2UMweLQ49G0MdNWB0W0WEYVlSRPl3LwpWzG/SsBAIYdO85N0ccqwnLuy2b2JZ4i6hNYKKVVHfjsJHoVnMCw9Y9Ccm8uFpZl4AXdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(136003)(376002)(346002)(26005)(966005)(53546011)(186003)(54906003)(8936002)(5660300002)(6512007)(2616005)(33656002)(6486002)(36756003)(6506007)(478600001)(71200400001)(41300700001)(122000001)(86362001)(91956017)(83380400001)(38070700005)(76116006)(6916009)(316002)(2906002)(8676002)(66446008)(4326008)(38100700002)(66946007)(64756008)(66476007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fBQ65v9YxRppbLMs9dbPk3gdu3HnXAfG8ZbpTkejH+TsdMKIzjxx5nINl7iX?=
 =?us-ascii?Q?ssxUWvYWHa7wdPfVUGHbZC3TxcZ4ty+8zI91hs5GuIdcA5PM0b9lWsZbNrt3?=
 =?us-ascii?Q?6rbO1mHMc5CPWkGT7ISqGCVHaND/Wa5Mp3pjvYPuZaT8zZHSRQFp3GSfuRy0?=
 =?us-ascii?Q?g2e+dnvjmt9mx666ufFK+2GXR3BY/KCHI14zGagsqMdltqlF1PjyNd+Wa7jW?=
 =?us-ascii?Q?xn6j0Z4WMRubUW+RBNOVbxphYBgTNoqa+xa+P9iNw3TizYq0xpVfZ8FJITEM?=
 =?us-ascii?Q?YNU/9yL9s5a1SEEbR7nht1ToJcX7vNskjulEv76duxneVO1SC2qU/IHnVDm7?=
 =?us-ascii?Q?Zeb7rYEAAkiKq9EyGr7YSaRC0iqlcY9Z8Wb6oBvM7YWEYGm6ngePprTejTG0?=
 =?us-ascii?Q?CZpFDBp24xduEiEuvLbNjXViadsUE3q1g7FJdRTBYV8OT7SQXptE/jyc6V7/?=
 =?us-ascii?Q?mdkn0H4+syWKusV5eBBtyef/UaocBUPEv8rrHnpVdnkobsrVmf8loUwvA4hE?=
 =?us-ascii?Q?x8Tyc/6QoW8aayMby5+nX/VHrOH/br+zoIZ1HetkR2qOS3nI87AEi08AtWa6?=
 =?us-ascii?Q?7w6kpF9I322UDBIrl644JwWpmUlHhTRQUWesT6h08g5APevsDSTJhjmmgbWy?=
 =?us-ascii?Q?f+ZA3x/uXGj4QoTSz0n7ilNv4hyCie/OIYn8hTMumkWamqRG8FtXGOHwFVwh?=
 =?us-ascii?Q?0AYLo51o40zduNnlEBiegqjSyiOG8O1DnB3e0+DoVc+U8iA8Drw5O3KqeP3S?=
 =?us-ascii?Q?CxGhvBqmrQduU2TODhNuPzstos78pQ8Y9zoLUJYOxYfkMuPYXgL5oCji6kPP?=
 =?us-ascii?Q?cgsCu8+YYB/f1+MjAdrdU8ZBNqJ/B0fwV5T77UczxwNXxDyIwq55VC+u+HQb?=
 =?us-ascii?Q?EoFVhXESM/xPijYvNgJ2fptTqQ300wuw9sbXkRUSCxZHL/BcrazJJpJloStt?=
 =?us-ascii?Q?jkXF/DUnm3zKhQIALj7o8D/EI6A0l93w+XIgeKCdKvvWn4HaVyMFSKiyHbHJ?=
 =?us-ascii?Q?yU+jmjhl+JsdLlV1hKQfIAooz1J/lRnCQfo2OF43Tmq9hwJ+77eeHphRNKqI?=
 =?us-ascii?Q?/2LJpCnZQOoJuNRKrAzLtXbG93zvl5vv729z1q22tM3mZnp7smGHXnrvMoCt?=
 =?us-ascii?Q?4E68e7Jrs4+sbN0LAuiwA+neyV7mQQszv5hgXy+Xf9zLY/rTlNnce6lMk123?=
 =?us-ascii?Q?3RJUiXutrmMJ+3N0a/3MLApn4Wuwiy+bw1c704iSMHXxXoJfOfo1HLe3BOs7?=
 =?us-ascii?Q?qAYx5SxCwQqFCU6ll4sV4GVZYCa1tRSPXAlg9g5MF0OaacAcYeo0JOF+VkWA?=
 =?us-ascii?Q?mOfjs6oe8B9kUWTCZa38dFUI+WB8dqc0tcsXHd2btfcLgPufBOLRNlxCr3jL?=
 =?us-ascii?Q?KaIkhh1a1LTJcle7ipsnq/8Xs8YKjdfDnDte+bIt9vGOGGdlDLty2KoDN2Jv?=
 =?us-ascii?Q?cWBy6rGJNQ0gvCSTMts8kA37dKSUc21KFiCEde3L33oqkJVVigKXq0DyCG4Z?=
 =?us-ascii?Q?WrLz+gjKUC1XsBoPx7C+5zDXZmp7zdqSxvZSi0k7IbLCOS8j1SQJAIiz662S?=
 =?us-ascii?Q?ElMhTHFv/pwFzieeMj364gIBt5UyqUUj3okaTJUPfvTP3iQE9b7w1epP7tEu?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACC8ED99C730FF43ABE1B2DCA98F329A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f8ae89-43d9-4e29-08f9-08da7626a5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 14:35:58.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZQjezAZRWNzHZCJvYOSVB8ndW2H5k7mrMPi6zfDp5IHjJcs6GLrpWiTbN9hwmUhxuFlKlJKylIX7CdJW5sPYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB5492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208040064
X-Proofpoint-GUID: pgH1XAsAgOFu8DHPysPTogaqKxBbROlS
X-Proofpoint-ORIG-GUID: pgH1XAsAgOFu8DHPysPTogaqKxBbROlS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

> On Aug 3, 2022, at 7:21 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 03 Aug 2022, Chuck Lever III wrote:
>>=20
>>> On Aug 3, 2022, at 2:55 AM, kernel test robot <lkp@intel.com> wrote:
>>>=20
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git master
>>> head:   42d670bda02fdba0f3944c92f545984501e5788d
>>> commit: 2743f3e0444f7287161ecf3e464ee2733dde412d [13556/14285] NFSD: ad=
d posix ACLs to struct nfsd_attrs
>>> config: parisc-defconfig (https://download.01.org/0day-ci/archive/20220=
803/202208031404.a1NgfSzI-lkp@intel.com/config)
>>> compiler: hppa-linux-gcc (GCC) 12.1.0
>>> reproduce (this is a W=3D1 build):
>>>       wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>>>       chmod +x ~/bin/make.cross
>>>       # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git/commit/?id=3D2743f3e0444f7287161ecf3e464ee2733dde412d
>>>       git remote add linux-next https://git.kernel.org/pub/scm/linux/ke=
rnel/git/next/linux-next.git
>>>       git fetch --no-tags linux-next master
>>>       git checkout 2743f3e0444f7287161ecf3e464ee2733dde412d
>>>       # save the config file
>>>       mkdir build_dir && cp config build_dir/.config
>>>       COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash
>>>=20
>>> If you fix the issue, kindly add following tag where applicable
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>=20
>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>=20
>>>>> ERROR: modpost: "set_posix_acl" [fs/nfsd/nfsd.ko] undefined!
>>>=20
>>> --=20
>>> 0-DAY CI Kernel Test Service
>>> https://01.org/lkp
>>=20
>> Neil, I've reproduced this and confirmed that the following addresses
>> the error:
>>=20
>> 464 #ifdef CONFIG_FS_POSIX_ACL
>> 465         if (attr->na_pacl)
>> 466                 attr->na_aclerr =3D set_posix_acl(&init_user_ns,
>> 467                                                 inode, ACL_TYPE_ACCE=
SS,
>> 468                                                 attr->na_pacl);
>> 469         if (!attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_m=
ode))
>> 470                 attr->na_aclerr =3D set_posix_acl(&init_user_ns,
>> 471                                                 inode, ACL_TYPE_DEFA=
ULT,
>> 472                                                 attr->na_dpacl);
>> 473 #endif
>>=20
>> I can squash this change into ("NFSD: add posix ACLs to struct nfsd_attr=
s").
>=20
> Thanks. I would prefer a fix like
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8a2731d2969d..eeeadd0b2f13 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -455,11 +455,13 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> 	if (attr->label && attr->label->len)
> 		attr->label_failed =3D security_inode_setsecctx(
> 			dentry, attr->label->data, attr->label->len);
> -	if (attr->pacl)
> +	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
> +	    attr->pacl)
> 		attr->acl_failed =3D set_posix_acl(&init_user_ns,
> 						 inode, ACL_TYPE_ACCESS,
> 						 attr->pacl);
> -	if (!attr->acl_failed && attr->dpacl && S_ISDIR(inode->i_mode))
> +	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
> +	    !attr->acl_failed && attr->dpacl && S_ISDIR(inode->i_mode))
> 		attr->acl_failed =3D set_posix_acl(&init_user_ns,
> 						 inode, ACL_TYPE_DEFAULT,
> 						 attr->dpacl);
>=20
>=20
> as that is consistent with similar usage in fs/ksmbd/ and with section
> 21 "Conditional Compilation' in coding-style.rst

I didn't realize:

> However, this approach still allows the C compiler to see the code
> inside the block, and check it for correctness (syntax, types, symbol
> references, etc).


I've applied your suggestion, compile-tested, and pushed it to the
NFSD for-next branch on kernel.org.


--
Chuck Lever



