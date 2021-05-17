Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2C382290
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 03:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhEQBiv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 May 2021 21:38:51 -0400
Received: from mail-mw2nam08on2057.outbound.protection.outlook.com ([40.107.101.57]:64640
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhEQBiv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 16 May 2021 21:38:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL6TC0KLL+0ycFBhiDmg3sZWiwDstvl4Obkbs7LQRcbpUyZ7HYLCS8MJfNu6s/TrtrF2vGpUD8Neqott5n4/GPKj/oEjdSVK6lXx02ICVm8/BaA/K7qMcgK6thMAXCze9WwCAt6se0wxALHdepztpukgTOxAQ9yB7umlSqUw7pagi5zd/jzHHFemx3h+P+rZhEOD1wI/9s5jZxjnMd8ttB4sw5+v83Vh5SZJ3NP4OJd4bnH1/528v8PRBQAIoxWH5fz9a4mdte0sv15B7y+yLvLazf93Xo0sYJPXH70phFE4vxW69p3IuIaXmvX6SWMhi1sRQHorFteRxtAsT77tLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GtJhBdJvNscqV6rN5303im41vXLbo0VWUfzfLIXoME=;
 b=TzQmPvWidj0VJKrBFOlhQ1tX2cJncPtNRy9dh6wrtdxjE85yCBstnpndVyJcv2g5vjRNrOAcY3X4wPEb9QKAsMmN0J58KUpgUHOsFJuNRD9cMVrlFuO7IgZhJkTmhfNkFChW05lkaWNRXDbztA4/u3IjCm+768OUrM5FxTthIsVvk/bV5vVUmWPfuPKtVV8kxXP34tIjW1z8sQkenJLnOjolJn8kLRsFEdDwDE6c2kG06jxzKkv7Bw9q1mLN2ExixyQq6LRgZxMNnHfR8EVucxPqmWkATGuijWTm0OrSqURm9qGFCnU5UKtEUaFArlWcyGq13tZNU9Y3t4NgZIlhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GtJhBdJvNscqV6rN5303im41vXLbo0VWUfzfLIXoME=;
 b=WXNmgSItXpV5jypykxB46n5yNIz12PnFOUohEbeJoHKUY8T2WfjqjVY9WE4ufj5HY/uscdnMCUsicC9Ra1Z7aaOtSdlrQSLjj++l3zscVnerji0uahjKYfCrh0QuE6SrMq6zuGXlut94GsOm70Ykav4i3ff1mPdEgcT0E+w1YH8=
Received: from CO1PR05MB8101.namprd05.prod.outlook.com (2603:10b6:303:fa::14)
 by MWHPR05MB3471.namprd05.prod.outlook.com (2603:10b6:301:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.24; Mon, 17 May
 2021 01:37:33 +0000
Received: from CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002]) by CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002%7]) with mapi id 15.20.4150.017; Mon, 17 May 2021
 01:37:33 +0000
From:   Michael Wakabayashi <mwakabayashi@vmware.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: NFSv4: Mounting NFS server which is down, blocks all other NFS mounts
 on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXA==
Date:   Mon, 17 May 2021 01:37:33 +0000
Message-ID: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [67.161.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e176d82d-060b-4462-0688-08d918d457ed
x-ms-traffictypediagnostic: MWHPR05MB3471:
x-microsoft-antispam-prvs: <MWHPR05MB34713E50E45463B0EDE74013B72D9@MWHPR05MB3471.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J6lX6aOadF9WsyByPIzN74uESJ1cnCyPKAbTW8W1iEmSPDF/W/CP2oiW8GU8eZikWz78RLfut/HDEecZucZ7w0m4vEUrP3mIrQv+kW83wlqAVC4aOFNH+08MxFEIJwIW952uxyhaJzl22ZmkA7t+3NMekNyI8nfnQJvmoZgGlQW1EtRYk20WDb1azFtKmt4kdMzmVsz2qqgKGQqyLMUOL5DneIRhDYgwsjYzgttOJrKV4/4rbHbwxmOXpM/obH0nNNt16h+N6bOXbj84kpB+FDsABx2SGSGkV0dlzrtEjceQse9R5jnqEPkdiXRFcK9Sm3VeBa0LB4qnQfjlXN7Twp5EA+JSNMBdNh4WDUDpXkPc0Ys4cSZxu3B8gKkGLyVigMeFTgZGMWrmklVIuZ7rerPM5UTS4TPFlpSeKP2ermSVP9ojzClJ7I5uOGuSzyW/Y75KgutWoi+pqY9YQeU6MEL6p2gs9VffPnAwiMqOEJ43OcWHIrGUjkhKWxCMkLcvIItqnES7LW8re4MaZosYO52RW+PKOZu+E8hVhhKhDgbzdio6S2xkZmzJuu2P0QifmezDw5VTf9kWj7oVIbZyAdGUsW4FeOcizNuEtUcZ4cFWNFVWBBDMUJUL65DsPXtPntHS4scvvMpd6985yIsLV2JXRyAGGKD1C73Y5S3N3awjXQguTMsehbYyTCuYjmx4Hh5MQMh5JqBO6wDXERz+zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8101.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(6506007)(966005)(66446008)(52536014)(33656002)(7696005)(186003)(8676002)(91956017)(26005)(66556008)(83380400001)(71200400001)(5660300002)(38100700002)(9686003)(64756008)(66476007)(8936002)(2906002)(86362001)(478600001)(6916009)(66946007)(122000001)(76116006)(55016002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?fttRJASrQlDsWB9ULj+YCHRNgncllG311McNgzyIB3imrufMJPutVlZ8Ng?=
 =?iso-8859-1?Q?4uVP4FhTdZqQQqzYhNascla0jpZIge+INhevkv1s2kqr3SZfmmN/+AkwCM?=
 =?iso-8859-1?Q?t215xlNRnV9uDvemwInfA5tSowBNBwapuie5FoJ8NNUryQR8zOpAu5MmGo?=
 =?iso-8859-1?Q?XcwO2R6reQMA6MHlSxNFggGZWe7zHUSn34HkRYtT7SAFyGCP8xjX7ZQ5ab?=
 =?iso-8859-1?Q?86KnH3nLCDwdQBa6Pryi8v1FSjMXMVqA90I1dn/H4iA63ZbEhLkTuXUsPB?=
 =?iso-8859-1?Q?pZsa9Ix/GrNek73jOYZor9WMknHq5HNVTi7VaTA6SRGwanNmgSezSg/D/2?=
 =?iso-8859-1?Q?5QxX6qJXO2KlvrW53KtyWH5Ci9Y+H4t7aIxzwLhcYVkemLbTEFBMdal4pU?=
 =?iso-8859-1?Q?CkAL76fak6JSKB22ovn5NQC8KTlmEP/ePAp8UYf9UCe8eWtmk5yt4yh3/E?=
 =?iso-8859-1?Q?cZivE/YI7J+/Rk9csLpM7Neyxg28cl/F0PHogGJpfPC1IEszp/QQM9D5xE?=
 =?iso-8859-1?Q?14z/zU5yK8pYF8Ttf9Hf5bm566KD4s6V5YF0CgaTzJJC1nhfGDgMjUpgYd?=
 =?iso-8859-1?Q?x/z7zP+hYbWxMjsT1tqWUCSzsWPhPn2pixm++jgQOTIi8IFWeBQHkpFybh?=
 =?iso-8859-1?Q?WYh16DnFsQ9WRkR0t/tKraUZM1Utn73aXNlko8vhswAkTJROWxPRyLi27n?=
 =?iso-8859-1?Q?zbLNNMe0x7m3r2cdQSLiQjR5VxA1CvNvBCuJ3trg6gYu6g1dz+9q5uS43y?=
 =?iso-8859-1?Q?XUKVGLJJsNSldbRczmg9myQ8aXUeW/49zX5pWcELgal9E5F/XnfkxSCyvc?=
 =?iso-8859-1?Q?DRdLuIa0kzlaq6m1QkKVbv1+5xOqbfZfknCfCtHDdyyPuKgEkrnsVnvgGR?=
 =?iso-8859-1?Q?tCXCOXwOY1eUEEkd+Qp6q9avKT2JVHyOPIxMhRhsIlB6TLMyn0YLt7AJpV?=
 =?iso-8859-1?Q?H4o8ViTnwMLbFRdmQpfb96YtdUDsQFDBs8+nmEHMohnhMFlzlyFjaS6XZf?=
 =?iso-8859-1?Q?OLqPpVTXdPCO0CGX4K5FmFKCKfwYsZPnZIpjd9jB93V9kp3bjZIjh6ZS/q?=
 =?iso-8859-1?Q?+FBRK/fIlkhAFqQxFZCvjJPTzSvqV/3nKVYcatBsdgneeOO+EjbwHKgR4z?=
 =?iso-8859-1?Q?FyFbyPWaRD0Bl2oddlB46mI3zTgyLB+sF+a/GqeLu2+kNQgihm3hRFSpLM?=
 =?iso-8859-1?Q?dVGQEGO1vMHRq6YcE7WWkQUZHTJYD8Jr0vEUCx1luBCC6K5OVzMastdsXe?=
 =?iso-8859-1?Q?nG6V+xTdrJHNND493PVmWYVsb3UTw91xwSs04UqDJ83JNyDCG19Fm/Hg9G?=
 =?iso-8859-1?Q?HxT8bNoJOKOM7m3C95h5KB4qye5Y/08ClQFckIm6UCuySug=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e176d82d-060b-4462-0688-08d918d457ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 01:37:33.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzWJB3/rEFq6KMcDIyymApbyIr8SAqoPikqopP2Bqca8tJgMTp6Z0zm7PBLm4dettH4fXNTfh+3ynLvF8T47/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3471
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,=0A=
=0A=
We're seeing what looks like an NFSv4 issue.=0A=
=0A=
Mounting an NFS server that is down (ping to this NFS server's IP address d=
oes not respond) will block _all_ other NFS mount attempts even if the NFS =
servers are available and working properly (these subsequent mounts hang).=
=0A=
=0A=
If I kill the NFS mount process that's trying to mount the dead NFS server,=
 the NFS mounts that were blocked will immediately unblock and mount succes=
sfully, which suggests the first mount command is blocking the other mount =
commands.=0A=
=0A=
=0A=
I verified this behavior using a newly built mount.nfs command from the rec=
ent nfs-utils 2.5.3 package installed on a recent version of Ubuntu Cloud I=
mage 21.04:=0A=
* https://sourceforge.net/projects/nfs/files/nfs-utils/2.5.3/=0A=
* https://cloud-images.ubuntu.com/releases/hirsute/release-20210513/ubuntu-=
21.04-server-cloudimg-amd64.ova=0A=
=0A=
=0A=
The reason this looks like it is specific to NFSv4 is from the following ou=
tput showing "vers=3D4.2":=0A=
> $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt=0A=
> [ ... cut ... ]=0A=
> mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "vers=3D4.2=
,addr=3D<unreachable-IP-address>,clien"...^C^Z=0A=
=0A=
Also, if I try the same mount.nfs commands but specifying NFSv3, the mount =
to the dead NFS server hangs, but the mounts to the operational NFS servers=
 do not block and mount successfully; this bug doesn't happen when using NF=
Sv3.=0A=
=0A=
=0A=
We reported this issue under util-linux here:=0A=
https://github.com/karelzak/util-linux/issues/1309=0A=
[mounting nfs server which is down blocks all other nfs mounts on same mach=
ine #1309]=0A=
=0A=
I also found an older bug on this mailing list that had similar symptoms (b=
ut could not tell if it was the same problem or not):=0A=
https://patchwork.kernel.org/project/linux-nfs/patch/87vaori26c.fsf@notaben=
e.neil.brown.name/=0A=
[[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]=0A=
=0A=
Thanks, Mike=
