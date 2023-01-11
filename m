Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16D665D39
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 15:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjAKOBe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 09:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjAKOBc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 09:01:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D705FE3
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 06:01:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F2BB61D25
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 14:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21112C433EF;
        Wed, 11 Jan 2023 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673445687;
        bh=rQF8yH501b82zYJbpVWW+cCh8qQ2qpeh2RbaawUUxkY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i4EZeSm6n3hzGukN3wr9CdWWM8OkzzVJhw3d40/G+EDPm5J6rS+7vu7McGwY9Bhpb
         +vsG6qkrPGlk9xDXU26Wi/qKkMB1qAnfsRsYTYMveEcdQ1OYUU+2iawKXK7ELFqYY2
         ZLg6GXTPW4QRMDqNEZjR8q3vDaB2ErdOvYz94SlEfWQp1PVMyK4nAqbz0EXEj71d4b
         m1Cp8eTd1/ipB+myp2So6sg+TV8WtrPiNsqLeIkJKSerklkv5JwgcIbpcdRebu2ui+
         SeDOM0smyXoknmje6LeABrIx2hEllUbV+gFI8PbxFn1H/h/BnCwKycqQH5QSHbc7x2
         nft7KPz4FPJyQ==
Message-ID: <69604dcf990ac19aa7c8d6b92d11c06fd1aae657.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     Mike Galbraith <efault@gmx.de>, dai.ngo@oracle.com,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 11 Jan 2023 09:01:25 -0500
In-Reply-To: <5f43a396afec99352bc1dd62a9119281e845c652.camel@kernel.org>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
         <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
         <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
         <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
         <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
         <ce3724b88bb2987ac773057f523aa0ed2abacaed.camel@kernel.org>
         <2067b4b4ce029ab5be982820b81241cd457ff475.camel@kernel.org>
         <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
         <fe19401301eac98927d6b4fc9fbf9c8430890751.camel@gmx.de>
         <5f43a396afec99352bc1dd62a9119281e845c652.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-11 at 07:33 -0500, Jeff Layton wrote:
> On Wed, 2023-01-11 at 13:15 +0100, Mike Galbraith wrote:
> > On Wed, 2023-01-11 at 12:19 +0100, Mike Galbraith wrote:
> > > On Wed, 2023-01-11 at 05:55 -0500, Jeff Layton wrote:
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > It might be interesting to turn up KASAN if you're able.
> > >=20
> > > I can try that.
> >=20
> > KASAN did not squeak.
> >=20
> > > > If you still have this vmcore, it might be interesting to do the po=
inter
> > > > math and find the nfsd_net structure that contains the above
> > > > delayed_work. Does the rest of it also seem to be corrupt?
> >=20
> > Virgin source with workqueue.c WARN_ON_ONCE() landmine.
> >=20
>=20
> Thanks. Mixed bag here...
>=20
>=20
> > crash> nfsd_net -x 0xFFFF8881114E9800
> > struct nfsd_net {
> >   cld_net =3D 0x0,
> >   svc_expkey_cache =3D 0xffff8881420f8a00,
> >   svc_export_cache =3D 0xffff8881420f8800,
> >   idtoname_cache =3D 0xffff8881420f9a00,
> >   nametoid_cache =3D 0xffff8881420f9c00,
> >   nfsd4_manager =3D {
> >     list =3D {
> >       next =3D 0x0,
> >       prev =3D 0x0
> >     },
> >     block_opens =3D 0x0
> >   },
> >   grace_ended =3D 0x0,
>=20
>=20
> >   boot_time =3D 0x0,
> >   nfsd_client_dir =3D 0x0,
> >   reclaim_str_hashtbl =3D 0x0,
> >   reclaim_str_hashtbl_size =3D 0x0,
> >   conf_id_hashtbl =3D 0x0,
> >   conf_name_tree =3D {
> >     rb_node =3D 0x0
> >   },
> >   unconf_id_hashtbl =3D 0x0,
> >   unconf_name_tree =3D {
> >     rb_node =3D 0x0
> >   },
> >   sessionid_hashtbl =3D 0x0,
> >   client_lru =3D {
> >     next =3D 0x0,
> >     prev =3D 0x0
> >   },
> >   close_lru =3D {
> >     next =3D 0x0,
> >     prev =3D 0x0
> >   },
> >   del_recall_lru =3D {
> >     next =3D 0x0,
> >     prev =3D 0x0
> >   },
> >   blocked_locks_lru =3D {
> >     next =3D 0x0,
> >     prev =3D 0x0
> >   },
>=20
> All of the above list_heads are zeroed out and they shouldn't be.
>=20
> >   laundromat_work =3D {
> >     work =3D {
> >       data =3D {
> >         counter =3D 0x0
> >       },
> >       entry =3D {
> >         next =3D 0x0,
> >         prev =3D 0x0
> >       },
> >       func =3D 0x0
> >     },
> >     timer =3D {
> >       entry =3D {
> >         next =3D 0x0,
> >         pprev =3D 0x0
> >       },
> >       expires =3D 0x0,
> >       function =3D 0x0,
> >       flags =3D 0x0
> >     },
> >     wq =3D 0x0,
> >     cpu =3D 0x0
> >   },
> >   client_lock =3D {
> >     {
> >       rlock =3D {
> >         raw_lock =3D {
> >           {
> >             val =3D {
> >               counter =3D 0x0
> >             },
> >             {
> >               locked =3D 0x0,
> >               pending =3D 0x0
> >             },
> >             {
> >               locked_pending =3D 0x0,
> >               tail =3D 0x0
> >             }
> >           }
> >         }
> >       }
> >     }
> >   },
> >   blocked_locks_lock =3D {
> >     {
> >       rlock =3D {
> >         raw_lock =3D {
> >           {
> >             val =3D {
> >               counter =3D 0x0
> >             },
> >             {
> >               locked =3D 0x0,
> >               pending =3D 0x0
> >             },
> >             {
> >               locked_pending =3D 0x0,
> >               tail =3D 0x0
> >             }
> >           }
> >         }
> >       }
> >     }
> >   },
> >   rec_file =3D 0x0,
> >   in_grace =3D 0x0,
> >   client_tracking_ops =3D 0x0,
> >   nfsd4_lease =3D 0x5a,
> >   nfsd4_grace =3D 0x5a,
>=20
> The grace and lease times look ok, oddly enough.
>=20
> >   somebody_reclaimed =3D 0x0,
> >   track_reclaim_completes =3D 0x0,
> >   nr_reclaim_complete =3D {
> >     counter =3D 0x0
> >   },
> >   nfsd_net_up =3D 0x0,
>=20
> nfsd_net_up is false, which means that this server isn't running (or
> that the memory here was scribbled over).
>=20
> >   lockd_up =3D 0x0,
> >   writeverf_lock =3D {
> >     seqcount =3D {
> >       seqcount =3D {
> >         sequence =3D 0x0
> >       }
> >     },
> >     lock =3D {
> >       {
> >         rlock =3D {
> >           raw_lock =3D {
> >             {
> >               val =3D {
> >                 counter =3D 0x0
> >               },
> >               {
> >                 locked =3D 0x0,
> >                 pending =3D 0x0
> >               },
> >               {
> >                 locked_pending =3D 0x0,
> >                 tail =3D 0x0
> >               }
> >             }
> >           }
> >         }
> >       }
> >     }
> >   },
> >   writeverf =3D "\000\000\000\000\000\000\000",
> >   max_connections =3D 0x0,
> >   clientid_base =3D 0x37b4ca7b,
> >   clientid_counter =3D 0x37b4ca7d,
> >   clverifier_counter =3D 0xa8ee910d,
> >   nfsd_serv =3D 0x0,
> >   keep_active =3D 0x0,
> >   s2s_cp_cl_id =3D 0x37b4ca7c,
> >   s2s_cp_stateids =3D {
> >     idr_rt =3D {
> >       xa_lock =3D {
> >         {
> >           rlock =3D {
> >             raw_lock =3D {
> >               {
> >                 val =3D {
> >                   counter =3D 0x0
> >                 },
> >                 {
> >                   locked =3D 0x0,
> >                   pending =3D 0x0
> >                 },
> >                 {
> >                   locked_pending =3D 0x0,
> >                   tail =3D 0x0
> >                 }
> >               }
> >             }
> >           }
> >         }
> >       },
> >       xa_flags =3D 0x0,
> >       xa_head =3D 0x0
> >     },
> >     idr_base =3D 0x0,
> >     idr_next =3D 0x0
> >   },
> >   s2s_cp_lock =3D {
> >     {
> >       rlock =3D {
> >         raw_lock =3D {
> >           {
> >             val =3D {
> >               counter =3D 0x0
> >             },
> >             {
> >               locked =3D 0x0,
> >               pending =3D 0x0
> >             },
> >             {
> >               locked_pending =3D 0x0,
> >               tail =3D 0x0
> >             }
> >           }
> >         }
> >       }
> >     }
> >   },
> >   nfsd_versions =3D 0x0,
> >   nfsd4_minorversions =3D 0x0,
> >   drc_hashtbl =3D 0xffff88810a2f0000,
> >   max_drc_entries =3D 0x14740,
> >   maskbits =3D 0xb,
> >   drc_hashsize =3D 0x800,
> >   num_drc_entries =3D {
> >     counter =3D 0x0
> >   },
> >   counter =3D {{
> >       lock =3D {
> >         raw_lock =3D {
> >           {
> >             val =3D {
> >               counter =3D 0x0
> >             },
> >             {
> >               locked =3D 0x0,
> >               pending =3D 0x0
> >             },
> >             {
> >               locked_pending =3D 0x0,
> >               tail =3D 0x0
> >             }
> >           }
> >         }
> >       },
> >       count =3D 0x0,
> >       list =3D {
> >         next =3D 0xffff888103f98dd0,
> >         prev =3D 0xffff8881114e9a18
> >       },
> >       counters =3D 0x607dc8402e10
> >     }, {
> >       lock =3D {
> >         raw_lock =3D {
> >           {
> >             val =3D {
> >               counter =3D 0x0
> >             },
> >             {
> >               locked =3D 0x0,
> >               pending =3D 0x0
> >             },
> >             {
> >               locked_pending =3D 0x0,
> >               tail =3D 0x0
> >             }
> >           }
> >         }
> >       },
> >       count =3D 0x0,
> >       list =3D {
> >         next =3D 0xffff8881114e99f0,
> >         prev =3D 0xffff88810b5743e0
> >       },
> >       counters =3D 0x607dc8402e14
> >     }},
> >   longest_chain =3D 0x0,
> >   longest_chain_cachesize =3D 0x0,
> >   nfsd_reply_cache_shrinker =3D {
> >     count_objects =3D 0xffffffffa0e4e9b0 <nfsd_reply_cache_count>,
> >     scan_objects =3D 0xffffffffa0e4f020 <nfsd_reply_cache_scan>,
>=20
> Shrinker pointers look ok, as does its list_head.

I think I might see what's going on here:

This struct is consistent with an nfsd_net structure that allocated and
had its ->init routine run on it, but that has not had nfsd started in
its namespace.

pernet structs are kzalloc'ed. The shrinker registrations and the
lease/grace times are set just after allocation in the ->init routine.
The rest of the fields are not set until nfsd is started (specifically
when /proc/fs/nfsd/threads is written to).

My guess is that Mike is doing some activity that creates new net
namespaces, and then once we start getting into OOM conditions the
shrinker ends up hitting uninitialized fields in the nfsd_net and
kaboom.

I haven't yet looked to see when this bug was introduced, but the right
fix is probably to ensure that everything important for this job is
initialized after the pernet ->init operation runs.
--=20
Jeff Layton <jlayton@kernel.org>
